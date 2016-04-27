From: Stefan Beller <sbeller@google.com>
Subject: Re: BUG on OSX `git p4 submit` can fail when the workspace root
 doesn't exist locally.
Date: Wed, 27 Apr 2016 13:53:50 -0700
Message-ID: <CAGZ79kZX5H8ddhZQa4r9SPyhAYo=o6gBae3oPCYQ6iNtxXq1Cg@mail.gmail.com>
References: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
	<CAGZ79kZ6rx4UpPmeGjC8TyHKbVd+Y6i1JyEdDzKuF_9rj4c_7g@mail.gmail.com>
	<CAMsgv2W7mtJpFf6A4MZs-Sbvdof8EdOOP+uiGYudH8LUjNRo8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jacob Smith <jaroslov@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:53:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWT5-0001ad-RC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcD0Uxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:53:52 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33874 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbcD0Uxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:53:51 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so52980862iow.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mjDamN/CN5NjEuSMBarToP/qZavbv6kwhbLKP81AXmQ=;
        b=St8BBKzAPr0WKWd5yneg90+hC+7pBg7Pf7iEew77wLAiIASnZvwaLn5/NoxeXAojVm
         vvxfP1EYHTS2thYCGd2CLPZ53gbqKoJaCZNHnfm3S2dOpOQdwweWeEc3as2snPUVNADa
         KRVMguVAyeUE+M+rw0THB+zc8B+rLfwUBkAkoU5JsbNgXxCxdaooksG/IajYJvRBVRWa
         3QTNEhqR5X3I7rSlhbXN6IKmZaW8UAJeqdseeyTedlQZ0fGp680T8V589dQ7tgPW7RKA
         YlI7lyvayTj9p7Q4XD8ODzNPmJEf4Xn5Ji4siwn93PRUpd9AtXR6Rxl9wgzt9RLHA8xi
         5sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mjDamN/CN5NjEuSMBarToP/qZavbv6kwhbLKP81AXmQ=;
        b=UAn/1j79pplBrbK34qJnMpYpfm+vsXCQpyyrhRYBewX1vrb0jjTJ3+NXKyXExwQoy8
         p7qIDMV9L6W4kgTrTVJC3/EqjZBIF1OClku5AyYn2m9ERYMlCau/oELFHcNsf0DZO3La
         NtmzpAWxfDiqkEM4/C2KQGL4l8wQAjwljg6GCgaHzq3kVomrxjEbGHXesNPaOfBDxmw4
         pNl0Xk0j44iw7PqUFKDKGcf4mIMwFKP0LNKkxpdvNwTEo5NsHzFmCNSqMCGOWQnZp1Ae
         3qNPeftIX3/UjXcH7QWuZV3QQFLyeYAbTze12LkClnDEgR1sgkIjnpzFq2G07KEtrSEv
         LIEg==
X-Gm-Message-State: AOPr4FWu9j661I0SdydZQ9Jvkr6FFtJq+rQ/XNafrQKSptxS/smugWwntogtwlH+DzuUVokgxF5zjhd8IhSNtUvK
X-Received: by 10.107.174.205 with SMTP id n74mr12797787ioo.96.1461790430252;
 Wed, 27 Apr 2016 13:53:50 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 13:53:50 -0700 (PDT)
In-Reply-To: <CAMsgv2W7mtJpFf6A4MZs-Sbvdof8EdOOP+uiGYudH8LUjNRo8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292823>

On Wed, Apr 27, 2016 at 11:06 AM, Jacob Smith <jaroslov@gmail.com> wrote:
> I debugged the issue using the script here:
>     https://github.com/git/git/blob/master/git-p4.py
> I'm not sure how close to the main repo that is.
>
> On Wed, Apr 27, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Apr 27, 2016 at 9:15 AM, Jacob Smith <jaroslov@gmail.com> wrote:
>>> On OS X,
>>
>> Do you use the Git as provided from OS X? In that case you better report the bug
>> to Apple, as their version of Git is slightly different (not close on
>> upstream, by both
>> having additional patches as well as not following the upstream closely IIUC).

In that case, I have cc'd Luke and Lars, who work on p4
