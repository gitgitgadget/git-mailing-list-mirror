From: yun sheng <uewing@gmail.com>
Subject: Re: Found a "bug" in git 1.9.0 but can't reproduce it without
 copyrighted source code.
Date: Fri, 28 Mar 2014 09:45:27 +0800
Message-ID: <CA+fYBFcqZtCxRjAiZk24VJutc_QT5asQU8EFRKpd0ZYqoN4=1g@mail.gmail.com>
References: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
	<20140328014022.GO15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 02:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTLrc-00018j-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 02:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256AbaC1Bpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 21:45:32 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50365 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbaC1Bp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 21:45:28 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so4135182pdj.12
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=csJtA6uzfVFc5vvv74LRDuJrGbwZTfWoo2qdQuUOtVI=;
        b=bs0hA+AqEiixOE1sym63nGD3BqGtQVjOeSsXqCOQ/RJWL39YC55/DehPt8MAsjoARH
         pDUH2TMVxl0xshGarBDFrPoqv74IRG51IcZ6Ta1xKCwPttr5FzB7Ip3Bk8KGTsdovAZ8
         q5wEQb9tqDObLPmAP5XMdgoE1RVqa8Fn4rJfJ28yQ4OqgutZgKlD93Uw/BoVeNe+YRdc
         6OEnICsqIyhqtFDq03jL9nrkEK0m7j8qtyq3oVXyArjc1GVYuYRjemfFf8Olhgm2yD0H
         ZNjG+HJsasj1ly3Y50pV7DwIkcfVJtMiELlpITNanslCImSy3TOSXOAPHCwYWEbyM9QC
         lL9A==
X-Received: by 10.66.181.70 with SMTP id du6mr5345874pac.23.1395971127897;
 Thu, 27 Mar 2014 18:45:27 -0700 (PDT)
Received: by 10.70.128.208 with HTTP; Thu, 27 Mar 2014 18:45:27 -0700 (PDT)
In-Reply-To: <20140328014022.GO15625@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245349>

The files get the same timestamp by using `git difftool -d` to view
diffs, the diff tool I use id beyond compare 3, this command would
generate temp files to feed the compare program, so these files get
the same time stamp, I copied them out from the temp folder.

I have no idea of the second quesiton, I am really not familiar with
windows API. Do you mean this file may have been changed without
rereading and git can't detect it?

Best regards,
Sheng Yun

On Fri, Mar 28, 2014 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> yun sheng wrote:
>
>> these two files have the same timestamp, the same size, bug slightly
>> different contents.
>
> How did they get the same timestamp?
>
> [...]
>> Git I'm using is msysgit 1.9.0 on windows 7
>
> Unixy operating systems have other fields like inode number and ctime
> that make it possible to notice that a file might have been changed
> without actually rereading it.  Unfortunately Git for Windows is
> limited to what's in the WIN32_FILE_ATTRIBUTE_DATA which means the
> size, mtime, and mode are basically all it has to go by.
>
> Do you know of some other Windows API call that could help?
>
> Hope that helps,
> Jonathan
