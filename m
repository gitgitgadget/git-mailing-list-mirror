From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 05/16] fetch-pack: support fetching from a shallow repository
Date: Tue, 23 Jul 2013 09:06:40 +0700
Message-ID: <CACsJy8C3Cb+W-GSnz2VzmRBvs980yKZNskGKqjG2+89JfHYEvQ@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <1374314290-5976-6-git-send-email-pclouds@gmail.com>
 <DADC072FCD7749C8B51D9DE594D67AB7@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 04:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1S0T-00042F-I3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 04:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3GWCHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 22:07:11 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:39691 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3GWCHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 22:07:10 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so9835781oag.40
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W6Pcyxj2KBteyJsHtHPhpmegZ1NZnhZbTH2BTkR9icM=;
        b=xdi4EsjIgNnxHmzVir1Jc25ViabKe5lJtvUuUvg8BTV/CzZK9eqYhew7m5BGq1uPED
         +IVVc6z1vzgkCAVLFo+M4BtabwelmzVuXXqi60SoZR3VY3SniIB0iL/mf+Mx1gxBLN6Z
         mUmUw5lCh+CQHfVncTLh+FKsj0RHkwYtmZIIap1KaMUvnAnTLAgu0tJ68mP6N2ryTUvv
         ak0Zo509K+W9iweHz8cIzxxtAOBwLMO7DnVBphwurydTkjdtmmBOA4g/hYpFkvu35yL8
         /MrFE6sL89uxclhlukvZT0tsMsYE6pwyVYf49C+YJVbWLja+3O8sz7eYLwNQsU0hABO8
         caJw==
X-Received: by 10.60.94.136 with SMTP id dc8mr28190168oeb.89.1374545230160;
 Mon, 22 Jul 2013 19:07:10 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Mon, 22 Jul 2013 19:06:40 -0700 (PDT)
In-Reply-To: <DADC072FCD7749C8B51D9DE594D67AB7@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231016>

On Tue, Jul 23, 2013 at 2:10 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>             And a full repository may automatically become shallow if
>> you fetch from a shallow repository.
>
>
> This "sounds" risky: Perhaps add a note about '[PATCH v2 15/16] config: add
> core.noshallow to prevent turning a repo into a shallow one' which will
> become available later in the series. The later core.noshallow may be a
> hostage to fortune.

core.noshallow is one way. Another is reject new shallow history (i.e.
no additions to .git/shallow) unless the user explicitly asks so
either via --depth or a new option --shallow. This does not mean that
fetching from a shallow clone always fails without either of those
options. The shallow clone may provide updates to an existing ref and
_not_ introduce new shallow grafts and that would be successful.
core.noshallow (or an opposite alternative) is probably the only way
for push.
--
Duy
