From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 2.8.0 gitignore enhancement not working as expected
Date: Fri, 18 Mar 2016 18:19:25 +0700
Message-ID: <CACsJy8Bjv=fF0CSNF_QNTCYCqQjy=j0ZEyjYOBFscz0HEYATig@mail.gmail.com>
References: <4a4980485c234280bce91be87d213216@XCH-RCD-003.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Richard Furness -X (rfurness - ENSOFT LIMITED at Cisco)" 
	<rfurness@cisco.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 12:20:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agsRk-0003Eu-M6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 12:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbcCRLT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 07:19:58 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35172 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcCRLT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 07:19:56 -0400
Received: by mail-lf0-f46.google.com with SMTP id v130so35416349lfd.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gwtNGigUSTKZsPpofCJOjbkj0XIWoRmx0xPoZ5B19rY=;
        b=w74J8HjihT3f2WHOnIEtDZbG1xehfPjPaAXDGXWwKiAc1sT7CMHKXYgBeeZ/3Ew6Ov
         uHcP5VjqytFnxamWzMkgPXLRbADLkLDsTKWZjqkeXNi9GHvE5t74++FO7Y6XUADZ8nnu
         N6Vv9QPEDSixM47DlukOdSd3fLlh9XoERbEZQLEhTNLcQLNXM7nK+NzdvrZfwxZ1Xrwx
         YvVyhNcsLh2Mkc4T8csondz8HBrXOiGZvTZHrk/3/Uj4d6xSnAL2A+3mf+WdrY7oN9Zb
         ZlyZIHi2TWHj7rV0IMP0LkyI+g4yn/9Z5PJ4t9UTNt9eE46sY1ZFvvFq5KNAujDdGcqq
         85Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gwtNGigUSTKZsPpofCJOjbkj0XIWoRmx0xPoZ5B19rY=;
        b=jkpa/Sllbi8s5/UxQhB3G1czZrEj3I4glC6VomIZRZJg1ylQvet4vKOAqXwLMrhCwU
         nOpGDlw5DJR8uY2ezveIoSDchig/nF1p8iFJonH0ffDNLQ2bfCLCeWQFdh606k8DZbAy
         QtYQ1oTerUM1J+8Rha/hB5V0ZrsJZ+Bbhv9ak3con3UOiT0USVMa20vWpw/NiLaX0E/G
         wRPIDlZkEJLqyG7lGtTDHzC2tNGnch1XICNNkqPONxzDL+KgXoGFlwZsQlSl5QoGiNWW
         aBenvmMK1dBboEwk+heF3VTQs4sno3b/imrM4uMuC2dsK5aNr97nBTRbHecaXH6OhDRk
         6UOA==
X-Gm-Message-State: AD7BkJIOkxgGCa8Tyj5ryF//iQujfCGGCzjwaSbCKa63xMGdJ0QboPkUz2ldnHdN9210tUBX1DrXoQ3eK0cbOQ==
X-Received: by 10.25.24.100 with SMTP id o97mr5925669lfi.112.1458299994671;
 Fri, 18 Mar 2016 04:19:54 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 04:19:25 -0700 (PDT)
In-Reply-To: <4a4980485c234280bce91be87d213216@XCH-RCD-003.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289215>

On Fri, Mar 18, 2016 at 4:31 PM, Richard Furness -X (rfurness - ENSOFT
LIMITED at Cisco) <rfurness@cisco.com> wrote:
> Hi,
>
> I've been testing out git 2.8.0 rc3 due to having a particular interest in this enhancement from the changelog:
> " Another try to improve the ignore mechanism that lets you say "this
>    is excluded" and then later say "oh, no, this part (that is a
>    subset of the previous part) is not excluded".  This has still a
>    known limitation, though."
>
> Currently, in order to include ONLY the files under a/b/c I have the following in .gitignore:
> /*             - Ignore everything
> !/a             - Except directory "a"
> /a/*            - Ignore all sub-directories of "a/"
> !/a/b           - Except "a/b"
> /a/b/*          - Ignore all sub-directories of "a/b/"
> !/a/b/c         - Except "a/b/c"
>
> My hope was that with this enhancement I could massively simplify this to:
> /*             - Ignore everything
> !a/b/c      - Except "a/b/c"
>
> However this doesn't seem to work - instead I find that NOTHING is ignored (i.e. it's as if the 2nd line completely cancels the first).

Interesting. It seems to be working for me. This is my test setup

> /tmp/abc $ find * -type f
1
a/1
a/b/1
a/b/c
> /tmp/abc $ cat .gitignore
/*
!a/b/c

and the results

> /tmp/abc $ ~/w/git/temp/git --version
git version 2.8.0.rc3
> /tmp/abc $ ~/w/git/temp/git ls-files -o --exclude-standard
a/b/c

Can you do "GIT_TRACE_EXCLUDE=1 git ls-files -o --exclude-standard"
and post the output?
-- 
Duy
