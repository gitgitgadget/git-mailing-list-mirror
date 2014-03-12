From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: Re: [PATCH] wt-status: i18n of section labels
Date: Wed, 12 Mar 2014 16:05:48 -0400
Message-ID: <5320BE1C.9020307@savoirfairelinux.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>	<20131219104613.GA18379@x230-buxy.home.ouaza.com>	<20131219194319.GB20443@google.com>	<xmqqa9cvmeod.fsf@gitster.dls.corp.google.com> <xmqqtxb3kyr2.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Raphael Hertzog <hertzog@debian.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= =?UTF-8?B?IEJqYXJtYXNvbg==?= 
	<avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVA==?= =?UTF-8?B?aMOhaSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 21:04:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpNo-0006tF-7v
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbaCLUED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 16:04:03 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:58410 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaCLUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:04:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7954B10D7238;
	Wed, 12 Mar 2014 16:04:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5G3ca8nUmU-u; Wed, 12 Mar 2014 16:04:01 -0400 (EDT)
Received: from [192.168.49.85] (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1EF2210D7237;
	Wed, 12 Mar 2014 16:04:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqtxb3kyr2.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243977>



Le 2014-03-12 15:22, Junio C Hamano a =C3=A9crit :
>   static const char *wt_status_diff_status_string(int status)
>   {
>   	switch (status) {
>   	case DIFF_STATUS_ADDED:
> -		return _("new file");
> +		return _("new file:");
>   	case DIFF_STATUS_COPIED:
> -		return _("copied");
> +		return _("copied:");
>   	case DIFF_STATUS_DELETED:
> -		return _("deleted");
> +		return _("deleted:");
>   	case DIFF_STATUS_MODIFIED:
> -		return _("modified");
> +		return _("modified:");
>   	case DIFF_STATUS_RENAMED:
> -		return _("renamed");
> +		return _("renamed:");
>   	case DIFF_STATUS_TYPE_CHANGED:
> -		return _("typechange");
> +		return _("typechange:");
>   	case DIFF_STATUS_UNKNOWN:
> -		return _("unknown");
> +		return _("unknown:");
>   	case DIFF_STATUS_UNMERGED:
> -		return _("unmerged");
> +		return _("unmerged:");
>   	default:
> -		return NULL;
> +		return _("bug");
> +	}
> +}

I don't see why _("bug") is returned when, later down,

> @@ -305,21 +346,16 @@ static void wt_status_print_change_data(struct =
wt_status *s,
>   	struct strbuf onebuf =3D STRBUF_INIT, twobuf =3D STRBUF_INIT;
>   	struct strbuf extra =3D STRBUF_INIT;
>   	static char *padding;
> +	static int label_width;
>   	const char *what;
>   	int len;
>
>   	if (!padding) {
> -		int width =3D 0;
> -		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
> -		for (status =3D 'A'; status <=3D 'Z'; status++) {
> -			what =3D wt_status_diff_status_string(status);
> -			len =3D what ? strlen(what) : 0;

checks for NULL.
