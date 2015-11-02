From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/5] read-cache: add watchman 'WAMA' extension
Date: Mon, 02 Nov 2015 17:03:19 -0500
Organization: Twitter
Message-ID: <1446501799.4131.24.camel@twopensource.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	 <1446386146-10438-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:03:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNCN-0000rw-8t
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbKBWDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 17:03:25 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34447 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbKBWDV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:03:21 -0500
Received: by qkcn129 with SMTP id n129so64428004qkc.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 14:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=ecxNn8txt1XzvpIW7HTpZuACAlvZa+R3jiMBxwt2gbQ=;
        b=fkDFI43pwmaOmRjXlBYkc/85OKlgUlupF8wIs7H8T1bl/+0KdqUz3qp6XjJkWpYAZP
         aGE7IceZETZqkgTWDy7AyjmnoBUjyUFuStsbIhorQG4gHtONTKymAsPLbHlDaoHfFHbh
         w06LexVXp39u9UvpHyBA5imWESOugcO6oeDYAZj/zVbtXmXSl6lBHEiO9iZRo7d+rIEf
         60ATFAAojIAsGRx//zlkX7y+UYEt6TsH4xTHnEoBoZK01w7SrE5dHm5EpAilgttKK3R8
         scvrvt6W7OQEHeQBZepZQ+ISIYxoVXYrCZDCKNolSOotEBN5tAOcdlt2QeX7fsWQl/B8
         dUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ecxNn8txt1XzvpIW7HTpZuACAlvZa+R3jiMBxwt2gbQ=;
        b=STPc9zRgvkuekP8nDHwRYvVweNRF0Rkwp/Yqru3l7vbL80Ud67dcwCtIXYSGePtJrZ
         +Hoz7SvegzotwKcvqlMdqPo4pTiKouDUkylxX1PQhdQ4dga0fHp8cpNMdypYNcrQD4DF
         dnxHemS6p0/s0dq5oRCd6nON4cHpBT8DN8gGbk9dxLk+U4+iJ8UP98KOoiRWIKnBVNhu
         tHStlmqMc09m7zbUUqBrpFCB3kgbMdbWn08VwRZdn/88Nleiz/McCNLrBdsQGIR3jJhT
         iklfBUDqo/43kKYqp3grkBUuJS4MbDK6tOVas/VUubPFLqKurn+CbgEmW3c8TZFGdFwB
         bFkQ==
X-Gm-Message-State: ALoCoQl+3CFGM9OUGOU+QM0cDWUmvgwu+xETHiEAUpHUxkY/AaIc+bW+uMAppgZcz0WHlTyQFlph
X-Received: by 10.55.78.84 with SMTP id c81mr32149187qkb.67.1446501800902;
        Mon, 02 Nov 2015 14:03:20 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e7sm8681482qkj.19.2015.11.02.14.03.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 14:03:19 -0800 (PST)
In-Reply-To: <1446386146-10438-2-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280727>

On Sun, 2015-11-01 at 14:55 +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
>
>+#define CE_NO_WATCH  (0x0001)

This name seems very confusing to me.  CE_NO_WATCHMAN_STAT?
CE_UNKNOWN_TO_WATCHMAN? =20

(one reason it may seem more confusing to me than to others is that
Twitter's code has a concept of files that we don't watch at all e.g.
Intellij's .idea dir). =20

> @@ -322,6 +325,7 @@ struct index_state {
>  	struct untracked_cache *untracked;
>  	void *mmap;
>  	size_t mmap_size;
> +	char *last_update;

Might be worth a comment explaining what this is.
