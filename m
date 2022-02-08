Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B4C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376649AbiBHNO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiBHMI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:08:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6CC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644322102;
        bh=W4+TLaB3ZMMUNqTEDifGFl0wG5wOOwWMHaOD9yUdY4M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SGMl+sdPgccFVxWmTcdkBOnH16JDNvPLo8tpb/bjAURGTzeY8PjuEJoXOX4rWVLZK
         +e5ipiCrjY0G+Xv17bX/PeWbc5nneW0+MTvhNnLIMLxrVNP9c1/2ULYoMkO27f+LqV
         5MKtR2N3BOiCwoi6r7au7emxbqiURDpgtH6uuJ9M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1nXMW81Bny-00H9UO; Tue, 08
 Feb 2022 13:08:22 +0100
Date:   Tue, 8 Feb 2022 13:08:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/6] Implement `scalar diagnose`
In-Reply-To: <ef70b87e-989b-e99c-b4ca-2b91c05defcf@web.de>
Message-ID: <nycvar.QRO.7.76.6.2202081303230.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com> <0d570137bb6aef675f4f5d74d140ace1dfba5eb7.1644187146.git.gitgitgadget@gmail.com> <ef70b87e-989b-e99c-b4ca-2b91c05defcf@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1648354016-1644322101=:347"
X-Provags-ID: V03:K1:z7C38DB2MLz/OxeYWMORy+nocM8SKZOylLpYQ0IKXcgxezz29fI
 E3iNEZG26s6Xg5eKeKKGCuklWYC11goiGHiDXo6zHj6rYzs7DEKZihe2Gy+HikjYsK13AHb
 c1Yym9oi7uBMRiUz7D2kxoCsnpmkgcUAajLAk/qZcCDypu9jNU13POvQ3I1mhnoTvVbue7T
 FyU+2SLie97YHaXu0LV2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4S0xPH802rM=:KlhdwLRGrE9Eu6v8R7XOsR
 RrxunzVryJnK0m3/ci3Zfq/wZ0qMXx2kpRINwTvbf9xbdE8U46t/qoogD6QcwLkyODAt6pHLg
 c7QvQndpIFcdDWEInKJbzELLA8O5zPGf/YY4/19A2WdrS4g/RbUm/32u8Fh0gN50I6Pvj7/M0
 9OdvxOnHndhAPJemKqrm7hVoDOXG6GWKbBWZ8B/Ds7q4OZPtMuJpt8EplN1rtdrNXN/Pijfss
 +vVKDDc9MRpeK9NwqyKoHEHIGDiTamZdvZYrU+nUt6qvqRD5OWNdpt6xiigWmJAJ7XXX14xrp
 zLMeN9wKzdzv56jr5ukSG7HxSjMmpwfcC7HIHR9g0jvWNTb4cdCD7CcCH2Mke02bVxa6NrBYf
 uvekYTvqmREt2n9t3ziAlPsgnN9FAwQ715HOZpjCOaKuJvyR97lNHpYKJqLXxSnk2aAybwVYT
 Gy8WyGxA2RrrZdKuK9xHjO5IHZENk4F7y4L7WWo6z95+aP83p8j5RY3fCUhVQhYx7a7Z23NX9
 MdsSgK5qMzKk4H05DiOB5I/jTrj0Izcz6p8nH3LN02BBrMxmbQyJogkggeOViKiq0J135AEK4
 LCU5uwkEZYUEpL9QYCZh89p4mdikhRMpSSYvtgWadRNOaLCBjrpnhqpZEkVsPwnlD3I0lAJ0l
 BLq8ka4u7xDHi1A8rUsuxKpzcJtRtjHNwkb9z08wf0c2/FW+mpNo41Msn/1VNP7PjF/CmY+JB
 KNF/4RfyXme6ixaoDGQwll/1mjrH17d9B8rKawoY0P4l+ClM6kZRs1HUf+mCJPuZNq0q1uByS
 6JTxnF45VAOomcz65+K408d65ovnGpcKFtHMYzrGfo5jJC+tleIGQk0gYAZcFLp+5zuLsOSOm
 XUrNMXmErMO8SiWCDg9Nl46kHZgfkAWhLSMDOg8/vTlcP/I8IultOXLlrA6xEeP+51My/el5p
 3pZbgASJ0imOGz3LUNoHfhLelsj1ZG9xR7kancj2+rnZ2DRdm6GzrKHHk0bOaK8eAYmx1I+gL
 qPvS1VNeLiLjFSzLFthIEIrNgcgg30ewOwkqinO0bXxGzHgKMM//3QGME/MGooiuQ/ZQD9ct3
 q3jqemLleTo8SI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1648354016-1644322101=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Mon, 7 Feb 2022, Ren=C3=A9 Scharfe wrote:

> > Note: originally, Scalar was implemented in C# using the .NET API, whe=
re
> > we had the luxury of a comprehensive standard library that includes
> > basic functionality such as writing a `.zip` file. In the C version, w=
e
> > lack such a commodity. Rather than introducing a dependency on, say,
> > libzip, we slightly abuse Git's `archive` command: Instead of writing
> > the `.zip` file directly, we stage the file contents in a Git index of=
 a
> > temporary, bare repository, only to let `git archive` have at it, and
> > finally removing the temporary repository.
> >
> > Also note: Due to the frequently-spawned `git hash-object` processes,
> > this command is quite a bit slow on Windows. Should it turn out to be =
a
> > big problem, the lack of a batch mode of the `hash-object` command cou=
ld
> > potentially be worked around via using `git fast-import` with a crafte=
d
> > `stdin`.
>
> The two paragraphs above are not in sync with the patch.

Whoopsie!

> > +	archiver_fd =3D xopen(zip_path.buf, O_CREAT | O_WRONLY | O_TRUNC, 06=
66);
> > +	if (archiver_fd < 0 || dup2(archiver_fd, 1) < 0) {
> > +		res =3D error_errno(_("could not redirect output"));
> > +		goto diagnose_cleanup;
> > +	}
> > +
> > +	init_zip_archiver();
> > +	strvec_pushl(&archiver_args, "scalar-diagnose", "--format=3Dzip", NU=
LL);
> > +
> > +	strbuf_reset(&buf);
> > +	strbuf_addstr(&buf,
> > +		      "--add-file-with-content=3Ddiagnostics.log:"
> > +		      "Collecting diagnostic info\n\n");
> > +	get_version_info(&buf, 1);
> > +
> > +	strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree)=
;
> > +	off =3D strchr(buf.buf, ':') + 1 - buf.buf;
> > +	write_or_die(stdout_fd, buf.buf + off, buf.len - off);
> > +	strvec_push(&archiver_args, buf.buf);
>
> Fun trick to reuse the buffer for both the ZIP entry and stdout. :)  I'd
> have omitted the option from buf and added it like this, for simplicity:
>
> 	strvec_pushf(&archiver_args,
> 		     "--add-file-with-content=3Ddiagnostics.log:%s", buf.buf);
>
> Just a thought.

Oh, that's even better. I did not like that `off` pattern at all but
forgot to think of `pushf()`. Thanks!

> > +
> > +	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) |=
|
> > +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks",=
 0)) ||
> > +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", =
0)) ||
> > +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/logs", =
1)) ||
> > +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/objects=
/info", 0)))
> > +		goto diagnose_cleanup;
> > +
> > +	strvec_pushl(&archiver_args, "--prefix=3D",
> > +		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
> > +
> > +	/* `write_archive()` modifies the `argv` passed to it. Let it. */
> > +	argv_copy =3D xmemdupz(archiver_args.v,
> > +			     sizeof(char *) * archiver_args.nr);
>
> Leaking the whole thing would be fine as well for this command, but
> cleaning up is tidier, of course.
>
> > +	res =3D write_archive(archiver_args.nr, (const char **)argv_copy, NU=
LL,
> > +			    the_repository, NULL, 0);
>
> Ah -- no shell means no command line length limits. :)

Yes!!!

It also makes the command a ridiculous amount faster on Windows.

> > +	if (res) {
> > +		error(_("failed to write archive"));
> > +		goto diagnose_cleanup;
> > +	}
> > +
> > +	if (!res)
> > +		printf("\n"
> > +		       "Diagnostics complete.\n"
> > +		       "All of the gathered info is captured in '%s'\n",
> > +		       zip_path.buf);
>
> Is this message appended to the ZIP file or does it go to stdout?

It goes to `stdout`, this is for the user who runs `scalar diagnose`.

Hmm.

Now that you pointed it out, I think I want it to go to `stderr` instead.

> In any case: mixing write(2) and stdio(3) is not a good idea.  Using
> fwrite(3) instead of write_or_die above and doing the stdout dup(2)
> dance only tightly around the write_archive call would help, I think.

Sure, but let's print this message to `stderr` instead, that'll be much
cleaner, right?

Alternatively, I think I'd rather move the `printf()` below...

>
> > +
> > +diagnose_cleanup:
> > +	if (archiver_fd >=3D 0) {
> > +		close(1);
> > +		dup2(stdout_fd, 1);
> > +	}

... this re-redirection.

What do you think? `stdout` or `stderr`?

Thank you for your review!
Dscho

--8323328-1648354016-1644322101=:347--
