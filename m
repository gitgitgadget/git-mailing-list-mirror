From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] git-p4: map a P4 user to Git author name and email address
Date: Sun, 28 Feb 2016 22:53:58 -0500
Message-ID: <CAPig+cQEzsJT+06bam2o+B1YTOrviHVtzE2LWsrF_bVCWy7+Bw@mail.gmail.com>
References: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
	<CAPig+cTCZ_diLH+tge6bis6gjq0Qvk05zD7zqf1PBJxNTJu9bw@mail.gmail.com>
	<F97BFD52-C258-4B8C-A380-6F0240FDE7F8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 04:54:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaEuL-0000b4-KQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 04:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbcB2DyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 22:54:00 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34705 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbcB2Dx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 22:53:59 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so8594730vkh.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 19:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0mgwivTo4xr4WjpGFDcfDNCxQCFayU93cKZ2aoy8gAA=;
        b=mI45p/hoflTTW3k7vpsAsC6jY8eoyKf343F56CrMNm4EliKzpLs4CCLKZYPUEkHcpV
         W9kvLn2jkiuLlFQujZEb03QKNKk/IBn7UxkeY45TfAevFx6+fMWy9qI+lRELJcSQQN7/
         RPx9wlhW+dH2O3jtLYUH1REKWIeP8jTVhqOB65KAcO7+ADLimm0cxgapDAYl++M0YL14
         cc8drWenaU9I/PlFYDLFstj/A0nPQ9IjZ4Dzy1P5sQscOGogcYYqIVLsMeRGz4GF0LUv
         cca+NkXrfNOc/bB+fElc7+WzxOhurluYUQJd3e3VjZXiRKPBKmaeLghDirNeXRzpdbGe
         glKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0mgwivTo4xr4WjpGFDcfDNCxQCFayU93cKZ2aoy8gAA=;
        b=gv2e/KHG6j/e9HtkwzWgjVjv+gSoiOqq0l4CV8nPjg6RNK7eUR6su8c0FsO7uoI1Jo
         i0Bggv7l1IS4SZA2rdaUJd4yRQUr7soK42hA/LtWL9+XZCUiSp4ZY0+lndtzmquHWCli
         GhltBGeOVbpH6WGbEC2ubjg2gAOaino4HW3YYzZYaHaaWNjxmBbHijwIkXtFxe0gtclX
         bTV2/zKwbsZ5WhXE/fLeILlhx3+UZqsldqB1zS+639LviG0DPmdQ9uA2oEucrCcYBPfT
         Mz6/3sjHm4IcNj10hiEWVTV2DaZAQJ/BASiLw1pe8H8HmRZ+Y6S/PW5FgAE/fLRNaNk5
         PR5Q==
X-Gm-Message-State: AD7BkJLGYG3r7u77Wxee78jiJDAAp02UXdBl5NYN5jzrmPyMYs8puJbi54KZBjvvnJT5u6EyLY2bLeegEEmU8w==
X-Received: by 10.31.8.142 with SMTP id 136mr10136700vki.14.1456718038631;
 Sun, 28 Feb 2016 19:53:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 28 Feb 2016 19:53:58 -0800 (PST)
In-Reply-To: <F97BFD52-C258-4B8C-A380-6F0240FDE7F8@gmail.com>
X-Google-Sender-Auth: FP9uTyaXpX_HDXtx74Tk1nr5lII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287797>

On Sun, Feb 28, 2016 at 12:05 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 28 Feb 2016, at 17:19, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Feb 28, 2016 at 5:25 AM,  <larsxschneider@gmail.com> wrote:
>>> +git-p4.mapUser::
>>> +       Map a P4 user to a name and email address in Git. Use a string
>>> +       with the following format to create a mapping:
>>> ++
>>> +-------------
>>> +git config --add git-p4.mapUser "p4user -> First Last <mail@address.com>"
>>> +-------------
>>> ++
>>> +       A mapping will override any user information from P4. Mappings for
>>> +       multiple P4 user can be defined.
>>
>> Does this format correctly with Asciidoc, or does the pargraph need to
>> be left-justified? (I haven't tested it myself.)
> I am not exactly sure what you mean. The last paragraph is already left
> justified, no?

Sorry, I meant "does it need to be flush against the left margin (that
is column 0)?" Just picking a file at random, (say
Documentation/blame-options.txt), you see quickly that while the first
paragraph of an entry is indented, subsequent paragraphs belonging to
that entry are not.

> Do you know a good tutorial for Asciidoc? How can I/should
> I check these things?

I haven't looked at tutorial; I've merely consult the Asciidoc
documentation when needed. Assuming you have the Asciidoc toolchain
installed, the easiest way to check if it formats correctly is to run
"make html" and then look at the built Documentation/git-p4.html in a
browser.
