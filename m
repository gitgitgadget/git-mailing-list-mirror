From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/8] ls_colors.c: enable coloring on u+x files
Date: Fri, 21 Mar 2014 18:52:43 +0700
Message-ID: <CACsJy8A2TaGvS0S9P1hOBmqXPTQszKcVTjXDEPX0kTrdN17Xxg@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-4-git-send-email-pclouds@gmail.com> <vpqpplhks7n.fsf@anie.imag.fr>
 <CACsJy8DP3buUjT95LwG+Kd70KL67xqEubrHfu9Mqx1RNa-ER2Q@mail.gmail.com> <xmqq7g7ozs0u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 12:53:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQy0l-0005lE-ER
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 12:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760185AbaCULxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 07:53:15 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44978 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbaCULxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 07:53:14 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so2243147qaq.2
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rsG5NY97dtVkBza8kTSMYnMaOhwzlQ9uY/+VGGEb8Tw=;
        b=TtX5iJ1HB8AD8UCojNmB6c/+fSkh5hka5KMgsNYKmT+RT1UvAgjGCtXh6gzBmJRP8O
         cASszc8kicInmf2pkZgZMtLgqhGVP8AjXVdbB1wPwqpt1LqX+jqqsyCLecJqBv7MqeY2
         mPX7/PLVjxWHqRAudEbxGLuD0A9VcF5UbItinlwaWb0dAfmQt5N6KmDoiq45k9q2Wxoo
         1CCu1cSTaHtY3Ulo7JYbXmfeslAftUtDocTvqNstBGSPkGrJ231YsZk5qzpkA524VcgN
         W/C/M929r0n4ZfJmpC45U9NxqfVz9sW3C0Rk93ykMpDqFLvkde2kfsACpMAxSNQrjK2N
         wcWA==
X-Received: by 10.224.112.6 with SMTP id u6mr31844834qap.78.1395402793353;
 Fri, 21 Mar 2014 04:53:13 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 21 Mar 2014 04:52:43 -0700 (PDT)
In-Reply-To: <xmqq7g7ozs0u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244686>

On Fri, Mar 21, 2014 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Why even include cache.h for S_IXUSR?
>
> In the context of the patch I see S_ISGID mentioned and other S_*
> st_mode things are already in use in this function before this step,
> and presumably you are using them without problems, no?

My mistake. git-compat-util.h does include S_IXUSR. The original code
was S_IXUGO that's in neither files.
-- 
Duy
