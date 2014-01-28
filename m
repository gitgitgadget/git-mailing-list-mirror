From: David Sharp <dhsharp@google.com>
Subject: Re: [PATCH v2] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 14:03:20 -0800
Message-ID: <CAJL_ekvepmKn6OmLYZWO==RMAbkkArAOLK1iASQG58ShKXU_4g@mail.gmail.com>
References: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
 <1390944060-783-1-git-send-email-dhsharp@google.com> <52E828AD.2040609@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 28 23:03:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Gkz-0007zG-89
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 23:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbaA1WDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 17:03:41 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50537 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbaA1WDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 17:03:40 -0500
Received: by mail-ie0-f181.google.com with SMTP id to1so1221579ieb.40
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 14:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XJz6oJ/c+qoPIKVc6BZms8KO1rgh1reI4WTmsg9ZjQI=;
        b=e3nKHr10wL2bXGA8Ova8Nej+ydXhhYbX3r7pNptI56XRveSJ28CPohaXWQfwGy1OnR
         G+64JSRDOo+LdiS4V22vPPEtRXMb/TnSkbdX6IfLiYDWw1H9CRkltgPMJZmQRZq6wytV
         H+vSmTi1/VSr4Vkg5kiB8NHlueCTdvo5SLWvi/6GLNM+6igFiXmH7wg7KbabfMNJv+0v
         L9n91taNHmWlnNXctPbiDCUPmq6XDN26tNHEw5trgve/uG+CgMffJ/D7vhqUWTSJbGXf
         rOrLCI3chhHw+Vk1zx1cdpfANi2eHc3aOspCVmgQh7XTgL1FjCJzLMafnlRDUH33gFON
         FK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XJz6oJ/c+qoPIKVc6BZms8KO1rgh1reI4WTmsg9ZjQI=;
        b=XZTt9vlnViUsC05OHERBGe89rkrmV5+LXtMMymbbUgVjRzFs0tETroZ4C7/bAU7Z6z
         cmWnbHMJXf2caxVMKyLp0bgRbHoRqRxJWC3Hct/8XteWc4M82vjg8n4f/hz7KvdXjQ3k
         xBfVRlirrxuxMFiUTfby8ivi/VaauujF21GJ+OHEgioFWtOEkMrbn9+oCRTYPm77pYDz
         5TVQ6X63mMADZBrxqG2rwR0cZQfWkEdi3/pqDCqlDkpNqyb9YRk6/HEvxkI/R0k/C6Le
         LarDaWDSnJbejMrOC53p5SdBYA419YkAX2vY38rtmwqgn6pr4wkREifxylkSzvIzg9FA
         BtCg==
X-Gm-Message-State: ALoCoQkm2en9r0233WH78WIcDSFt9uI4a+s0DW8ytY8g4nbN0oSEAUUARkrqGeIEnLgtzUOBb3ti6q+bVDIV8VmULyFL185eDbY50XR1FfTffdl9Dzlkwf8aqV8PBCzzlBZkx7CxVwbx1OXfa9eYw+nk0ghk4fAigKxyWIYzClE/deHGWbaQ279T1erZBEoeKfdTJqaf8r3D
X-Received: by 10.50.239.162 with SMTP id vt2mr25408071igc.48.1390946620114;
 Tue, 28 Jan 2014 14:03:40 -0800 (PST)
Received: by 10.64.224.137 with HTTP; Tue, 28 Jan 2014 14:03:20 -0800 (PST)
In-Reply-To: <52E828AD.2040609@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241197>

On Tue, Jan 28, 2014 at 2:01 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 28.01.2014 22:21, schrieb David Sharp:
>> @@ -738,9 +740,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>                               continue;
>>                       }
>>                       if (!strcmp(arg, "--resolve-git-dir")) {
>> -                             const char *gitdir = resolve_gitdir(argv[i+1]);
>> +                             const char *gitdir = argv[++i];
>>                               if (!gitdir)
>> -                                     die("not a gitdir '%s'", argv[i+1]);
>> +                                     die("--resolve-git-dir requires an argument");
>> +                             gitdir = resolve_gitdir(gitdir);
>> +                             if (!gitdir)
>> +                                     die("not a gitdir '%s'", argv[i]);
>>                               puts(gitdir);
>>                               continue;
>>                       }
>
> In this hunk, I don't see where the old code incremented i for the
> argument. Was this another bug lurking that is fixed now?

Yup. I did notice that too. Should have mentioned it in the description.

>
> -- Hannes
>
