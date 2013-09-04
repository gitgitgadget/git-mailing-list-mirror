From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Wed, 4 Sep 2013 02:45:07 -0400
Message-ID: <CAPig+cTmVfrRWNfoqUGbZnf=GhozSnBB+rm1uuKAZRiRYHr7Xg@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 08:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH6q4-0003Tu-41
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 08:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762057Ab3IDGpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 02:45:10 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37937 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761963Ab3IDGpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 02:45:09 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so16889lbj.13
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ipaDoUEJyknjoyuLm9ifPJFySzYouyuVpcqBq+eXBmI=;
        b=KH7C5qVaL2RtMxYaG5Km6Npmx3YeqcprEMeWEUo6O/x/e4RDAzpQVnpDs+jaBmwC+Z
         +5bTkLaezjwQfRl099muBtZj2NThFXJxDL6IS76A4eE3iJsPsCFpvjZOGyye0adUk0m5
         Al+qUFpIK2fwszQX9XwKSuFHDD/cyPk1a4qOCMAy1dmo14wlmxpN6KAegtj5GuRqHeD/
         meNvgbkSfdkfXTQktdb83Mtk8xiAI49vtR6brQCnBYT387Qk81jTpv1EKohxacNeGbMU
         LGm3ED6s1irgUuR6yq+8bF0qZPuGAOCRthLaHymi+xdU+f7ToQgh5QbhhH2Spe0jpyxe
         mF/g==
X-Received: by 10.112.156.166 with SMTP id wf6mr1175245lbb.13.1378277107436;
 Tue, 03 Sep 2013 23:45:07 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 3 Sep 2013 23:45:07 -0700 (PDT)
In-Reply-To: <CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
X-Google-Sender-Auth: 5RECnIFJqYmIXAeXxcqubZl49YI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233810>

On Wed, Sep 4, 2013 at 2:36 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> On Wed, Sep 4, 2013 at 6:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not care too deeply either way, but I am curious if there was a
>> reason why you changed the earlier <directory> to <path>?  Somehow,
>> when we _know_ a path has to be a directory, I find it easier on the
>> readers to spell that out, instead of saying "this is a path",
>> implying that it could be a directory, a regular file, or even
>> non-existent.
>
> Eric made me do it :). Personally I prefer the non-ambiguous "directory"
> over "path". In fact, "directory" is used in the error message spat out
> by git:
>
>     $ git --work-tree
>     No directory given for --work-tree.
>     ...
>
>     $ git --git-dir
>     No directory given for --git-dir.
>     ...
>     $
>
> I think changing "<path>" to "<directory>" wherever appropriate in
> git.txt would be an improvement. Tangent: <dir> is shorter but that
> might not be easy on the translators.

Such a terminology change is orthogonal to the patch adding -C
support, so if you do pursue it, the terminology change should be a
separate patch (either preparatory or follow-up to the -C patch).
