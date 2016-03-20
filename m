From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 17:05:21 +0530
Message-ID: <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 12:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahbdo-0003kA-JL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 12:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbcCTLfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 07:35:25 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33507 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbcCTLfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 07:35:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id a140so5702804ywe.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PLib98501tR/wRtPrQfYuPNRAzLhamDfuUUo5VvfPBk=;
        b=m+SatEQMsmsSldf/GEXy2Tw1hRUj30fk5lG3QVrYlLfm+ScRpds5/0NBHDykzBBuxB
         zI4Y1lkyRyXpolqcHnQ/EQ1VHPyA7FkrmXi2TUGWZpLj8nGHJeufgaykNQ4Oi5Ssozd+
         wLYxAqMQLu1TbNxWyfMAHCTJeFtpu9FBzefBCjcP+J6K5Qr/qRBvPOasN+spXzRZEdDv
         W7+bm9yq6jw9OI+NDTGK+NMQaAV7EoTFZxiYwCadDaURIEyQwvBFy9WCeFFsG40Md4+j
         +ebAZHKjOIxnr72JPtanDh+1+nQZIGXvwBGlm7T1aK2GbB3DZazU1/DArQeyv7t2GuHX
         CpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PLib98501tR/wRtPrQfYuPNRAzLhamDfuUUo5VvfPBk=;
        b=YpwPY79gDZoNlo4X68z8bOa0gFr0GMC7AGg2/TRqwYvUU6ZIvRehPEsOibOVIx96kj
         KBFwLH5vc6+v1j7vWAGKB+XatiNoiT2+8W6tGt8M8vBwuxAW1avtcq3kPUVCJCYo5uac
         /LpQDGWvnaiUxuzbHkKJ0CEei7s91rA+j9TdkkQkMmx+Xz0QD6t4BMmmaOWiInaG7Xub
         p9V6+IrQYk5UtcbbEZwNlCSIbOHXxmSR4e29fzQ7ZS2TMN6gDWs6uKbk6KpC5bLW+2mh
         zXb/BXaKjM15E28uRoAaG12TecDwcl3kjQNGJDPUtMq5u68RjJPGZNCbyispbazAe0bJ
         NuFQ==
X-Gm-Message-State: AD7BkJIxklECFuP5reZ0V3O67iivhNO3C2vH8jZmm4xKvf39DtO33hUynSlO17YLbeP7d/r1QjBUeNeLIZLsLg==
X-Received: by 10.37.12.195 with SMTP id 186mr11576827ybm.154.1458473721911;
 Sun, 20 Mar 2016 04:35:21 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 04:35:21 -0700 (PDT)
In-Reply-To: <CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289347>

The project Idea: Incremental Rewrite from shell to C of git-bisect.sh

The plan:

 - Place bisect.c in builtin/
 - Implement a skeletal cmd_bisect() which will redirect to
git-bisect.sh (1e1ea69f)
 - Introduce a structure for parsing the command line flags.
 - Start converting individual functions and place it in bisect.c

The major objective would be to replicate function behavior rather
than its actual implementation because what might seem to be a good
choice in bash would not be a good choice in C and vice versa. For eg.
bisect_skip() externally calls the command `git rev-list HEAD` to get
a list of commits and then store the standard output in an array as
bash can directly do the conversion, but it would not be a good thing
to do in C. This might involve a very different approach to the
existing code. To take care of this part, I will extensively debug
git-bisect.sh and the other files it depends on ie. rev-list.c,
rev-parse.c, for-each-ref.c, list_objects.c and bisect.c to study
their behavior . I will spend some time in testing the functions for
corner cases and running the ready-made tests to investigate its
behavior. The goal would be to produce quality code that can be
included in the next maintenance release 2.7.5. I will try to
extensively review the patches myself first and then add it on the
mailing list. I intend to discuss the whole structure of bisect.c
based on my observations in the first week. Then accordingly send
individual patches for each method. Also I am quite unsure how the
patches would be maintained by Junio. Would he create a separate
branch for me in his personal repo and then add the patches to it
without merging it to pu and then when it is completely done, the
merge will take place? Or he will individually first place every patch
in pu and the normal process?

Functions I intend to cover (This is from a first-read, I haven't
actually debugged it. It might miss some technicalities or deviate
from actual) :

 - bisect_head() : This tests whether there exists a regular file
named "BISECT_HEAD". If it exists then it prints out the contents of
it otherwise it prints the contents of current HEAD pointer.

 - bisect_autostart() : This sees if there exists a non-empty file
"BISECT_HEAD". If yes, then it checks if standard input is available.
If yes, then it asks whether the user wants to automatically start
bisect.

 - bisect_start() : It calls `git rev-parse` with the arguments that
this function was called to get the SHA-1 of the refs in the git repo.
Then, if this repo is a bare one then it uses the flag
`--no-checkout`. It then parses the options and accordingly updates
the state variables. It then checks whether the user ran "git bisect
start <sha1> <sha2>". If yes, then it assigns bad commit to sha1 and
good commit to sha2. It then gets the path of HEAD pointer and stores
its SHA-1 in head. The it checks whether the user has already started
bisecting. If it has started, then it will reset to where it
previously started. It will then get rid of any old bisect state. Then
it will write new start state by putting the ref in BISECT_START, add
them in BISECT_NAMES, and then store the log of the good and bad
commit in BISECT_LOG. Then it will check whether the user can proceed
to the next bisect state by using system signals.

 - bisect_write() : It understands whether the commit is good or bad
and initializes variables accordingly. This will get the current ref
to the commit it is on. It will then print its state in BISECT_LOG.

 - is_expected_rev() : It checks whether the argument matches the
contents of  BISECT_EXPECTED_REV

 - check_expected_rev() : It removes the revs BISECT_ANCESTORS_OK and
BISECT_EXPECTED_REV is they fail the is_expect_rev() test

 - bisect_skip() : It specifies a range/single commit which needs to
be skipped and then call bisect_state() with the required arguments to
skip.

 - bisect_state() : It will first start auto bisect. It then verifies
the ref and calls it bisect_write with the state and ref. Then it
calls bisect_auto_next()

 - bisect_check_next() : It will check whether there exists a ref for
a good commit and a bad commit. If not then it will just report it. It
can bisect with only 1 bad commit without a good commit.

 - bisect_auto_next() : It checks whether bisection for next is
possible. If yes then it calls bisect_next().

 - bisect_next() : It calls first bisect_autostart() and it calls
bisect_check_next() with the good commit. Then it will perform the
bisection computation, display the results and then checkout. Then it
will check if it should exit because bisection is finished. And then
check for an error in the bisection process.

 - bisect_visualize() : It will call gitk and git log (if gitk is not
available) and pass on the arguments also.

 - bisect_reset() : It checks for the file BISECT_START, if present
then it will first checkout to the branch/commit/ref specified in the
argument and then call bisect_clean_state().

 - bisect_clean_state() : It will update all the refs which bisect
changed safely with the help of `git update-ref`. It will then remove
all the extra refs which bisect introduced during bisection.

 - bisect_replay() : It first calls bisect_reset(). Then it reads from
log file and then runs git bisect and marks the commits good or bad
all by itself using the information obtained from log file.

 - bisect_run() : This basically checks whether the script you
provided with the arguments that you provided with and performs a
fully automated bisection.

 - bisect_log() : Prints the contents of BISECT_LOG

 - get_terms() : It reads the contents of BISECT_TERMS and stores the
SHA-1 of good commits and bad commits.

 - write_terms() : This will write good commit and bad commit in
proper format to BISECT_TERMS

 - check_term_format() : Checks whether BISECT_TERMS has a proper
SHA-1 and nothing else.

 - check_and_set_terms() : It verify and set the good/bad or new/old
commit SHA-1 in BISECT_TERMS

 - bisect_voc() : simple switch case to print "bad|new" if argument is
"bad" and "good|old" if argument is "good".

 - bisect_terms() : It will first receive terms using get_terms() or
by using the arguments passed to it.


Should I also include "How git bisect works internally?" in the
proposal along with this?
This is not my "first look" of the proposal. I am still working on the
proposal. Half way there!

And most importantly, Would anyone like to mentor me for this project?
