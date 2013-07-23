From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 05/16] fetch-pack: support fetching from a shallow repository
Date: Tue, 23 Jul 2013 21:39:55 +0700
Message-ID: <CACsJy8A1naHQZ-DRnqBq8OWdLHa2U4dEhKw=nnOqh-yjmHpE_w@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-6-git-send-email-pclouds@gmail.com>
 <DADC072FCD7749C8B51D9DE594D67AB7@PhilipOakley> <CACsJy8C3Cb+W-GSnz2VzmRBvs980yKZNskGKqjG2+89JfHYEvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 16:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1dlQ-0008Pu-75
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607Ab3GWOk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:40:27 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40762 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757484Ab3GWOk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:40:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so8480718pab.41
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kyxuVmE9FEPJ0sR64yko6Dm0hwcx578tS2EJse2wzu8=;
        b=Ti0jsuShTTMz6wrp5ayYO7T/GDJnljzqL84TyuQLBw4DC3cgAInLw5yBAeIAxn5RlL
         gMPH8Zo4jpWKN/CYQYRSlwk6XxhNCNHCfjzR69Y8LpOnJb82tDh6dhzj4hA2ryr6seUO
         ww4lnlSiJxK/0QjqMYDM6ELE5LcoLF7tb5pE9MEWdPaKuMQRZcRpH0ZkviM+dLDWs1q3
         sNRmg3UNRBasr3gKExFt6H5ZD8ZYUkOOoJsBKGl0RCc+S8dEexKHvMLuGd9dDlyMmlv3
         qfMEajEXWvSrE5Xsu7REJUvsDlOZ1CysbfI/kMdNeNxbErAQF0EzQEN7ZrLJvh9aqD5z
         1hjA==
X-Received: by 10.66.134.132 with SMTP id pk4mr37432606pab.20.1374590425577;
 Tue, 23 Jul 2013 07:40:25 -0700 (PDT)
Received: by 10.70.82.169 with HTTP; Tue, 23 Jul 2013 07:39:55 -0700 (PDT)
In-Reply-To: <CACsJy8C3Cb+W-GSnz2VzmRBvs980yKZNskGKqjG2+89JfHYEvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231042>

On Tue, Jul 23, 2013 at 9:06 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Another is reject new shallow history (i.e.
> no additions to .git/shallow) unless the user explicitly asks so
> either via --depth or a new option --shallow. This does not mean that
> fetching from a shallow clone always fails without either of those
> options.

The above was at pack level when I wrote that, although I think, from
the user perspective, rejecting at ref level makes more sense. That is
if a fetch request returns one ref update with incremental updates and
one with new shallow history, instead of rejecting the whole request,
we reject the second ref update and accept the first one.
--
Duy
