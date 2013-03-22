From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Support triangular workflows
Date: Fri, 22 Mar 2013 13:11:30 +0530
Message-ID: <CALkWK0=Mca1YiT0HVVrLrzmN2hGWuMJZPvNKNzb=0H7TxXuYwQ@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com> <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:42:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwcO-0004NT-08
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3CVHlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:41:51 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51077 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3CVHlu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:41:50 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so537013iec.13
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EYJ9nkneR1hQ2HFstFfzF31WpjIAOp1U5M57FyofOxI=;
        b=ZO2RxgTHRBbL249OrCCC0Vx2xJNgAAj8hiwqDCMqCYE3h1ggw1NNfsuuEGQehqd5hH
         l4HwFQeecRmkiEb2ysHUHxUzK8WHviWIbxXZkWFqb+GbOsHmNQ5u8hWgX4DXgORPEKof
         zZ53v9KXtuFwHG6NlvJMgYqxpdeefWKnqu+CVQQh4ulH35nfJNAYy9S6kuUYZVL3G5AX
         cypFE86oAyhrem1WpeQwhSM2K2rMEYAYiEdJQMDrghJ2+KisDoh70grNEM94f/FVRLCP
         eL+26pO8r0qmqGsgiT36zhN0i4+N7CZeXhbopOdwdCrJa9/z7o8cj0QLYdxnqJ5pRzrK
         QxyQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr387962icb.57.1363938110064;
 Fri, 22 Mar 2013 00:41:50 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Fri, 22 Mar 2013 00:41:30 -0700 (PDT)
In-Reply-To: <26A2BE0824FE4C999592D392FCBEF988@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218776>

Philip Oakley wrote:
> From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> Sent: Wednesday, March 20, 2013 12:44 PM
>
>> This follows-up [1], with three important differences:
>>
>> 1. pushremote_get() and remote_get() share code better.  Thanks Jeff.
>>
>> 2. All spelling mistakes have been corrected.  Thanks Eric.
>>
>> 3. One new test for each of the new configuration variables.  The
>> extra two parts [2/6] and [3/6] preprare the file for introducing
>> tests.  However, I've not gone overboard in this preparation; I don't
>> replicate the work done by Jonathan in [2].
>>
>> Thanks for reading.
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/218410
>> [2]:
>> http://thread.gmane.org/gmane.comp.version-control.git/218451/focus=218465
>>
>> Ramkumar Ramachandra (6):
>>  remote.c: simplify a bit of code using git_config_string()
>>  t5516 (fetch-push): update test description
>>  t5516 (fetch-push): introduce mk_test_with_name()
>>  remote.c: introduce a way to have different remotes for fetch/push
>>  remote.c: introduce remote.pushdefault
>>  remote.c: introduce branch.<name>.pushremote
>>
>> Documentation/config.txt | 23 +++++++++++++++---
>
>
> Shouldn't Documentation/gitworkflows.txt also be updated with the triangular
> workflow and its configuration?

Currently, Documentation/gitworkflows.txt makes no effort to explain
how to set up configuration variables for centralized or distributed
workflows.  I don't see how I could patch the existing document to
include this workflow, without changing the entire structure of the
document (left as an exercise for future patches).
