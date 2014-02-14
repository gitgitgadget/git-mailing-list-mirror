From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Sat, 15 Feb 2014 00:10:41 +0100
Message-ID: <52FEA271.2030405@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>	<52FBC9E5.6010609@gmail.com>	<loom.20140213T193220-631@post.gmane.org>	<52FD4C84.7060209@gmail.com>	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>	<52FE68C9.3060403@gmail.com>	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com> <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW
 5-yxBEbGkd6O+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Zager <szager@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zachary Turner <zturner@chromium.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 00:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WERu7-0005Xm-HV
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaBNXKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:10:40 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:33948 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbaBNXKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:10:39 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so5976655eek.38
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 15:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZArdq91yFc41pIcl+W8kb8BXgmgViyZzq2Zse9QFNWM=;
        b=xpeWKFxYEXbyL2QwWlb47fOoya0d5/qKksgQk1+mmYCniUJCWJCL/RWYhbmvJE8XsS
         87gwdwwbozCW8u424wO5ru5SY5nZ0Ty4Dc0bIZDMMSlsTtEeY0MjY42b+HNmOoFLPcTR
         HpqPHN8HzF9MODIaxkXgQNQg813hob6dDtireu5v/j1JxPJFNuCsFxWgrjshgmzOzu53
         Zz8qGhHnFecPP4zJNuTBd56V+0AWUOn/NrplG7vTFgehaA4tyet9dm3dRbfqz69xL2Xk
         nKsRDq1O2M5cY56E8LH5Ud0UDWaqi6MoRX26jCX7amjH+3zn1Jj1mGVbxwgKj+PWXoWL
         87kA==
X-Received: by 10.14.119.197 with SMTP id n45mr2436209eeh.93.1392419437916;
        Fri, 14 Feb 2014 15:10:37 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v6sm25142119eef.2.2014.02.14.15.10.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 15:10:36 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242157>

Am 14.02.2014 20:16, schrieb Zachary Turner:
> For the mixed read, we wouldn't be looking for another caller of
> pread() (since it doesn't care what the file pointer is), but instead
> a caller of read() or lseek() (since those do depend on the current
> file pointer).  In index-pack.c, I see two possible culprits:
> 
> 1) A call to xread() from inside fill()
> 2) A call to lseek in parse_pack_objects()
> 
> Do you think these could be related?  If so, maybe that opens up some
> other solutions?
> 

Yeah, I think that's it. The problem is that the single-threaded part (parse_pack_objects/parse_pack_header) _also_ calls pread (via sha1_object -> get_data_from_pack -> unpack_data). So a pread() that modifies the file position would naturally be bad in this single-threaded scenario. Incidentally, that's exactly what the lstat64 in the version below fixes (similar to git_pread).

> BTW, the version you posted isn't thread safe.

It is true that, in a multi-threaded scenario, my version modifies the file position in some indeterministic way. However, as you noted above, the file position is irrelevant to pread(), so that's perfectly thread-safe, as long as all threads use pread() exclusively.

Using [x]read() in one of the threads would _not_ be thread-safe, but we're not doing that here. Both fill()/xread() and parse_pack_objects()/lseek() are unreachable from threaded_second_pass(), and the main thread just waits for the background threads to complete...

>>> A simple alternative to ReOpenHandle is to reset the file pointer to its
>>> original position, as in compat/pread.c::git_pread. Thus single-theaded code
>>> can mix read()/pread() at will, but multi-threaded code has to use pread()
>>> exclusively (which is usually the case anyway). A main thread using read()
>>> and background threads using pread() (which is technically allowed by POSIX)
>>> will fail with this solution.
>>>
>>> This version passes the test suite on msysgit:
>>>
>>> ----8<----
>>> ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
>>> {
>>>         DWORD bytes_read;
>>>         OVERLAPPED overlapped;
>>>         off64_t current;
>>>         memset(&overlapped, 0, sizeof(overlapped));
>>>         overlapped.Offset = (DWORD) offset;
>>>         overlapped.OffsetHigh = (DWORD) (offset >> 32);
>>>
>>>         current = lseek64(fd, 0, SEEK_CUR);
>>>
>>>         if (!ReadFile((HANDLE)_get_osfhandle(fd), buf, count, &bytes_read,
>>> &overlapped)) {
>>>                 errno = err_win_to_posix(GetLastError());
>>>                 return -1;
>>>         }
>>>
>>>         lseek64(fd, current, SEEK_SET);
>>>
>>>         return (ssize_t) bytes_read;
>>> }
>>>
>>
