From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2010, #06; Wed, 20)
Date: Thu, 21 Jan 2010 02:06:23 +0100
Message-ID: <fabb9a1e1001201706i4c7ffaecs55153c9220bc5992@mail.gmail.com>
References: <7vljfsxos5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXlVY-0002an-NB
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 02:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab0AUBGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596Ab0AUBGo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 20:06:44 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52982 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab0AUBGo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 20:06:44 -0500
Received: by pwj9 with SMTP id 9so3572479pwj.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=axBjCZulWADNBQl0vz5EABKwARz0CO2gkPWAYVjKLKM=;
        b=fh1HJazvqFde/FiBiWb6X1Vke/WYywyoAyX3fqC8IXM8p8M/an0si2PiHXcHdGbg1Q
         bhUh0ExiiNZfM3nzHY0a0q2OTcdwwDll/65aYRCdSD3WShrAsbAitVWE3z/ocDqtOl52
         TNF9im1DSp+59SL1+WDY+WaWMU+F3ZnmOtU0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VqDGh+uW32AsMgRIcmEqwZeQtBFa3JuwUXjN2vMY7m01dCq5HYo9wf0+Ogo8217jm1
         x9cDioI/R/U1c3W1BLOetkklbxTBx0UwopYP+jTw/464tI3WHEH/6Z5y1116oZvMejsV
         hhd2FIkqftUPabcIWq5cnF6+b6KZmsWks+jdw=
Received: by 10.143.24.15 with SMTP id b15mr521681wfj.41.1264036003176; Wed, 
	20 Jan 2010 17:06:43 -0800 (PST)
In-Reply-To: <7vljfsxos5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137608>

Heya,

On Thu, Jan 21, 2010 at 01:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> * jh/notes (2010-01-17) 23 commits
> =A0- builtin-gc: Teach the new --notes option to garbage-collect note=
s
> =A0- Notes API: gc_notes(): Prune notes that belong to non-existing o=
bjects
> =A0- t3305: Verify that removing notes triggers automatic fanout cons=
olidation
> =A0- builtin-notes: Teach -d option for deleting existing notes
> =A0- Teach builtin-notes to remove empty notes
> =A0- Teach notes code to properly preserve non-notes in the notes tre=
e
> =A0- t3305: Verify that adding many notes with git-notes triggers inc=
reased fanout
> =A0- t3301: Verify successful annotation of non-commits
> =A0- Builtin-ify git-notes
> =A0- Refactor notes concatenation into a flexible interface for combi=
ning notes
> =A0- Notes API: Allow multiple concurrent notes trees with new struct=
 notes_tree
> =A0- Notes API: write_notes_tree(): Store the notes tree in the datab=
ase
> =A0- Notes API: for_each_note(): Traverse the entire notes tree with =
a callback
> =A0- Notes API: get_note(): Return the note annotating the given obje=
ct
> =A0- Notes API: remove_note(): Remove note objects from the notes tre=
e structure
> =A0- Notes API: add_note(): Add note objects to the internal notes tr=
ee structure
> =A0- Notes API: init_notes(): Initialize the notes tree from the give=
n notes ref
> =A0- Add tests for checking correct handling of $GIT_NOTES_REF and co=
re.notesRef
> =A0- Notes API: get_commit_notes() -> format_note() + remove the comm=
it restriction
> =A0- Minor non-functional fixes to notes.c
> =A0(merged to 'next' on 2010-01-02 at ae42130)
> =A0+ Add more testcases to test fast-import of notes
> =A0+ Rename t9301 to t9350, to make room for more fast-import tests
> =A0+ fast-import: Proper notes tree manipulation
>
> Updated with a re-roll.

Just checking, you reverted all from next (with exception of the first
three), and now re-queued it to pu, with the first three still in
next? Or did I mis-remember and did only the first three make it to
next in the first place?

--=20
Cheers,

Sverre Rabbelier
