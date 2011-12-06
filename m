From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 12:22:06 +0100
Message-ID: <CABPQNSbOReM71HaPmce3v_98NDu17fT3YnySR4pWzJEDa-RKnA@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org> <20111206055239.GA20671@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 12:22:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXt6v-0005pZ-4B
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 12:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196Ab1LFLWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 06:22:49 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53516 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab1LFLWr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 06:22:47 -0500
Received: by dadv6 with SMTP id v6so5087604dad.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 03:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KmEwNB+VqGvFxfoA/doDsqwjfsbILy3i1cEyqSm0QtU=;
        b=vpF21MCtdWmuinUUOlCPRKvyhCM2DNdS9ZXJ2RXImtak8dCTTQloScEdRaaTo0LXco
         Z1C5byKD6zkHari3ac1zCVOQC1bbU7oWV2cp5W1adEC/8W+f4YB/NUePMGL+R7g5ea/Z
         ijlcxusZaFPVdHDWCwHSSbBjyPK6wNJhkST3Q=
Received: by 10.68.29.37 with SMTP id g5mr19884696pbh.122.1323170567229; Tue,
 06 Dec 2011 03:22:47 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Tue, 6 Dec 2011 03:22:06 -0800 (PST)
In-Reply-To: <20111206055239.GA20671@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186343>

On Tue, Dec 6, 2011 at 6:52 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 05, 2011 at 09:01:52PM -0800, Junio C Hamano wrote:
>
>> * jk/credentials (2011-11-28) 20 commits
>> =A0- fixup! 034c066e
>> =A0- compat/getpass: add a /dev/tty implementation
>> =A0- credential: use git_prompt instead of git_getpass
>> =A0- prompt: add PROMPT_ECHO flag
>> =A0- stub out getpass_echo function
>> =A0- refactor git_getpass into generic prompt function
>> =A0- move git_getpass to its own source file
>> =A0- t: add test harness for external credential helpers
>> =A0- credentials: add "store" helper
>> =A0- strbuf: add strbuf_add*_urlencode
>> =A0- credentials: add "cache" helper
>> =A0- docs: end-user documentation for the credential subsystem
>> =A0- credential: make relevance of http path configurable
>> =A0- credential: add credential.*.username
>> =A0- credential: apply helper config
>> =A0- http: use credential API to get passwords
>> =A0- credential: add function for parsing url components
>> =A0- introduce credentials API
>> =A0- t5550: fix typo
>> =A0- test-lib: add test_config_global variant
>>
>> Expecting a reroll?
>
> Yes, I have a re-roll ready. I was holding back to see if some of the
> helper authors might comment, but got nothing. Perhaps the new versio=
n
> will spur some interest.
>
> Also, let's drop the top git_getpass bits from the topic for now (the=
y
> will not be part of my rebase). They are a separate topic that can go=
 on
> top, but I think there was some question from Erik of whether we shou=
ld
> simply roll our own getpass().
>
>> * jk/upload-archive-use-start-command (2011-11-21) 1 commit
>> =A0- upload-archive: use start_command instead of fork
>>
>> What's the status of this one?
>
> I think what you have in pu is good, but of course I didn't actually
> test it on Windows. Erik?
>

I tried to check out ee27ca4 and build, and got hit by a wall of warnin=
gs:

compat/mingw.h: In function 'waitpid':
compat/mingw.h:117: warning: pointer targets in passing argument 1 of
'_cwait' differ in signedness
d:\msysgit\mingw\bin\../lib/gcc/mingw32/4.4.0/../../../../include/proce=
ss.h:60:
note: expected 'int *' but argument is of type 'unsigned int *'

This seems to be an issue that has been around since the birth of the
windows port, and can be fixed by making our waitpid signature
identical to what POSIX expects
(http://pubs.opengroup.org/onlinepubs/7908799/xsh/waitpid.html):

---8<---
diff --git a/compat/mingw.h b/compat/mingw.h
index a255898..2036013 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -111,7 +111,7 @@ static inline int mingw_unlink(const char *pathname=
)
 }
 #define unlink mingw_unlink

-static inline int waitpid(pid_t pid, unsigned *status, unsigned option=
s)
+static inline int waitpid(pid_t pid, int *status, int options)
 {
 	if (options =3D=3D 0)
 		return _cwait(status, pid, 0);

---8<---

But then, there's a couple of much more scary warnings:

decorate.c: In function 'hash_obj':
decorate.c:11: warning: dereferencing type-punned pointer will break
strict-aliasing rules
<snip>
object.c: In function 'hash_obj':
object.c:48: warning: dereferencing type-punned pointer will break
strict-aliasing rules
<snip>
builtin-merge-recursive.c: In function 'cmd_merge_recursive':
builtin-merge-recursive.c:49: warning: unknown conversion type characte=
r 'z' in
format
builtin-merge-recursive.c:49: warning: format '%s' expects type 'char *=
', but ar
gument 2 has type 'unsigned int'
builtin-merge-recursive.c:49: warning: too many arguments for format

Looking at the code, the first two looks like the real thing, and not
just false positives.

IIRC, the strict aliasing rule is not a part of C89, but is in C99.
And GCC starts to generate code that depends on strict-aliasing rules
with -O3. We don't use -O3, so this might be theoretical, at least on
my machine at this time.

The last one is a usage if "%zu", which our printf doesn't support.
This comes from commit 73118f89 ("merge-recursive.c: Add more generic
merge_recursive_generic()"), and should probably be fixed by doing:
---8<---
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 703045b..02242cc 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -45,8 +45,9 @@ int cmd_merge_recursive(int argc, const char **argv,
const char *prefix)
 			bases[bases_count++] =3D sha;
 		}
 		else
-			warning("Cannot handle more than %zu bases. "
-				"Ignoring %s.", ARRAY_SIZE(bases)-1, argv[i]);
+			warning("Cannot handle more than %"PRIuMAX" bases. "
+				"Ignoring %s.",
+				(uintmax_t)ARRAY_SIZE(bases)-1, argv[i]);
 	}
 	if (argc - i !=3D 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
---8<---

But no matter what, something has clearly happened to our warning
level, and that should probably be investigated.

Back to topic: after fixing these (apart from the strict aliasing
issues), t5000-tar-tree pass fine here. So I guess that's at least
something. I haven't tested from git-daemon yet, but I don't have time
for that right now...

I'll submit the first fix later tonight, as it's clearly an
improvement IMO... but perhaps it's better if Stephan just squash in
the latter in the next round of the series, since it seems to be in a
pu-only series so far?
