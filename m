From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 09:20:41 -0500
Message-ID: <CAMP44s0uFLDanLP=w2ozVG665rCFq5kK7b5Mk_RWYEv39YqCqw@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8BRYHkSj1YR9mW=_tdKX_+xKNxpVx+RNYEdoW3S36w=8Q@mail.gmail.com>
	<CAMP44s1jtqGXhFN+KqODR-ooe1BiyQNVD=08nDF0poBc+madxw@mail.gmail.com>
	<CACsJy8D=oZ0Y0F8_WFfVxgFtnsRJtxxp9y2oQgoxpxd3zU+rsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uimfn-00056A-EC
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3FAOUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:20:44 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46717 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3FAOUn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:20:43 -0400
Received: by mail-wi0-f174.google.com with SMTP id c10so1472087wiw.7
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=otka4fkRzMzuwSZQ7KSQtGLvvS8M8TB+VoXClGomcHI=;
        b=Ef4bugq1y/ygkbj0Kx6hdLA8Mx3swFnYSocpiKHQ22DcQvbZaCQmw34l/i8mgEhoYB
         X6GVQmvd073XR/VUFqsV3G5N9wYN0xPz7KwU8+JXKxooSRqEx3lpvi+LSL+pUOAGxveg
         vhcPDlJNKynJb1Wd3nr+J+qoqMQK/vugAORXpfwgbs7fHsMhfPhfkuPVSz64aitsPIyB
         I17umX8Jc3eZJtBELm5Y2F26Hw1AqW0yVgbxNEMx7+919fBl1yuk29oUpRZCWQ3uWUGa
         /Kkx6FKDuE0RXrh4HPLy+8rqA5P4JipjmqizflGKR9AC781dtxKzzOb8SjCIFQWrlhU6
         sfWQ==
X-Received: by 10.194.77.66 with SMTP id q2mr13170836wjw.34.1370096441925;
 Sat, 01 Jun 2013 07:20:41 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 07:20:41 -0700 (PDT)
In-Reply-To: <CACsJy8D=oZ0Y0F8_WFfVxgFtnsRJtxxp9y2oQgoxpxd3zU+rsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226132>

On Sat, Jun 1, 2013 at 9:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 9:06 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Jun 1, 2013 at 9:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> Nobody is checking for specific error codes; it's the errno that's
>>>> important.
>>>
>>> Have you just disregarded the in-code comment you just removed with
>>> one statement?
>>
>> Who cares about the comment? As I said, nobody is checking for those codes.
>
> Apparently I do.

Why do you care about code comments that have no relation to reality?

>>> Did you check all its callers?
>>
>> Yes, that's why I said nobody is checking for those codes.
>
> Thanks. If would be a few mails less if you stated so in the original message.

So why did you think I said that that nobody is checking for those codes?

Anyway, apparently somebody added code that checks for the specific
code since I wrote this patch:

1250857 launch_editor: propagate signals from editor to git

To my knowledge this is the only place where the specific number us
actually checked.

-- 
Felipe Contreras
