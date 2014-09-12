From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Fri, 12 Sep 2014 14:50:23 +0200
Message-ID: <5412EC0F.5090601@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <540C6A02.9070403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:57:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSQPt-00055Q-KT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 14:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbaILM53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2014 08:57:29 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47932 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751882AbaILM52 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 08:57:28 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2014 08:57:28 EDT
X-AuditID: 1207440f-f79156d000006a5c-3a-5412ec121649
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 42.D5.27228.21CE2145; Fri, 12 Sep 2014 08:50:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1EE6.dip0.t-ipconnect.de [93.219.30.230])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8CCoNf8000681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Sep 2014 08:50:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <540C6A02.9070403@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqCv0RijE4PkeGYuuK91MFg29V5gt
	nsy9y2zxo6WH2aKz4yujA6vHw1dd7B7Pevcwely8pOzxeZOcx+1n21gCWKO4bZISS8qCM9Pz
	9O0SuDN6dl9gK5gZULHzz1SWBsbFNl2MnBwSAiYSk57MYIOwxSQu3FsPZHNxCAlcZpR4MP0i
	K4RznklizY5XjCBVvALaEk8P/gbrYBFQldi/+RBYnE1AV2JRTzMTiC0qECDxofMBVL2gxMmZ
	T1hABokItDNKrJ/ZBjSVg4NZwEhi3ul6kBphASeJPz+vM4PYQgJxEhOebGIHsTkF1CTaLn1k
	BbGZBdQl/sy7xAxhy0s0b53NPIFRYBaSFbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJi
	Xl5qka6JXm5miV5qSukmRkiQ8+9g7Fovc4hRgINRiYe3gkUwRIg1say4MvcQoyQHk5Iob949
	oRAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrw3XgHleFMSK6tSi/JhUtIcLErivOpL1P2EBNIT
	S1KzU1MLUotgsjIcHEoSvF0gjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgWI0v
	BkYrSIoHaG822N7igsRcoChE6ylGS44Pv172MnFM2vgeSK7r/NbPJMSSl5+XKiXOu/QlUIMA
	SENGaR7cOliqe8UoDvS9MO96kLE8wDQJN/UV0EImoIXv5oAtLElESEk1MDb+f5+42llz5/+1
	ii2Kh4Tau3qap0i/cylqqdi4lVn5r8ubnIUTJ111bSlfFtqxKSw4QO2OYPurKzL3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256918>

On 09/07/2014 04:21 PM, Torsten B=C3=B6gershausen wrote:
>=20
> On 2014-09-06 09.50, Michael Haggerty wrote:
>> Sorry for the long delay since v3. This version mostly cleans up a
>> couple more places where the lockfile object was left in an
>> ill-defined state.=20
> No problem with the delay.
> The most important question is if we do the lk->active handling right=
=2E
> Set it to false as seen as possible, and to true as late as possible,
> then die() cleanly.
> So the ->acive handling looks (more or less, please see below) and
> deserves another critical review, may be.
>=20
> Instead of commenting each patch, I collected a mixture of small ques=
tions
> and possible suggestions into a diff file.
>=20
> diff --git a/lockfile.c b/lockfile.c
> index e54d260..7f27ea2 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -18,6 +18,10 @@
>   *    Usually, if $FILENAME is a symlink, then it is resolved, and t=
he
>   *    file ultimately pointed to is the one that is locked and later
>   *    replaced.  However, if LOCK_NODEREF is used, then $FILENAME
> +LOCK_NODEREF can be read either as
> +LOCK_NODE_REF or LOCK_NO_DEREF
> +should we change it ?
> +

Good idea.

>   *    itself is locked and later replaced, even if it is a symlink.
>   *
>   * 2. Write the new file contents to the lockfile.
> @@ -46,9 +50,18 @@
>   *   state:
>   *   - the lockfile exists
>   *   - active is set
> - *   - filename holds the filename of the lockfile
> + *   - filename holds the filename of the lockfile in a strbuf

I don't think this is necessary. The point of this list is to describe
the state machine, not the contents of the lock_file structure, so this
detail is only a distraction. And even if a reader is confused, the
compiler will warn if he tries to use the strbuf as if it were a string=
=2E

>   *   - fd holds a file descriptor open for writing to the lockfile
>   *   - owner holds the PID of the process that locked the file
> +question: Why do we need the PID here ?
> +Do we open a lock file and do a fork() ?
> +And if yes, the child gets a new PID, what happens when the
> +child gets a signal ?
> +Who "owns" the lockfile, the parent, the child, both ?
> +The child has access to all data, the fd is open and can be used,
> +why do we not allow a rollback, when the child dies ?

Good questions. I will add an explanation of the purpose of the pid in
this docstring.

>   *
>   * - Locked, lockfile closed (after close_lock_file()).  Same as the
>   *   previous state, except that the lockfile is closed and fd is -1=
=2E
> @@ -57,7 +70,7 @@
>   *   rollback_lock_file(), or a failed attempt to lock).  In this
>   *   state:
>   *   - active is unset
> - *   - filename is the empty string (usually, though there are
> + *   - filename is an empty string buffer (usually, though there are
>   *     transitory states in which this condition doesn't hold)
>   *   - fd is -1
>   *   - the object is left registered in the lock_file_list, and
> @@ -68,7 +81,7 @@
> =20
>  static struct lock_file *volatile lock_file_list;
> =20
> -static void remove_lock_file(void)
> +static void remove_lock_files(void)

Good idea. I will rename these two functions.

>  {
>      pid_t me =3D getpid();
> =20
> @@ -79,9 +92,9 @@ static void remove_lock_file(void)
>      }
>  }
> =20
> -static void remove_lock_file_on_signal(int signo)
> +static void remove_lock_files_on_signal(int signo)
>  {
> -    remove_lock_file();
> +    remove_lock_files();
>      sigchain_pop(signo);
>      raise(signo);
>  }
> @@ -93,7 +106,7 @@ static void remove_lock_file_on_signal(int signo)
>   * "/", if any).  If path is empty or the root directory ("/"), set
>   * path to the empty string.
>   */
> -static void trim_last_path_elm(struct strbuf *path)
> +static void trim_last_path_elem(struct strbuf *path)

I agree that the old name was bad. I will make it even more explicit:
trim_last_path_component().

>  {
>      int i =3D path->len;
> =20
> @@ -143,7 +156,7 @@ static void resolve_symlink(struct strbuf *path)
>               * link is a relative path, so replace the
>               * last element of p with it.
>               */
> -            trim_last_path_elm(path);
> +            trim_last_path_elem(path);
> =20
>          strbuf_addbuf(path, &link);
>      }
> @@ -153,13 +166,16 @@ static void resolve_symlink(struct strbuf *path=
)
>  /* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int fla=
gs)
>  {
> +    struct stat st;
> +    int mode =3D 0666;
>      if (!lock_file_list) {
>          /* One-time initialization */
> -        sigchain_push_common(remove_lock_file_on_signal);
> -        atexit(remove_lock_file);
> +        sigchain_push_common(remove_lock_files_on_signal);
> +        atexit(remove_lock_files);
>      }
> =20
> -    assert(!lk->active);
> +  if (lk->active)
> +        die("lk->active %s", path);

OK, but I will use die("BUG:...") since this would be an indication of =
a
bug in git.

>      if (!lk->on_list) {
>          /* Initialize *lk and add it to lock_file_list: */
> @@ -167,16 +183,25 @@ static int lock_file(struct lock_file *lk, cons=
t char *path, int flags)
>          lk->active =3D 0;
>          lk->owner =3D 0;
>          lk->on_list =3D 1;
> -        strbuf_init(&lk->filename, 0);
> +        strbuf_init(&lk->filename, strlen(path) + LOCK_SUFFIX_LEN);

OK.

>          lk->next =3D lock_file_list;
>          lock_file_list =3D lk;
>      }
> =20
> +    strbuf_reset(&lk->filename); /* Better to be save */

I agree, but this would be a bug so I'd rather die("BUG:") in this case=
=2E

>      strbuf_addstr(&lk->filename, path);
>      if (!(flags & LOCK_NODEREF))
>          resolve_symlink(&lk->filename);
>      strbuf_addstr(&lk->filename, LOCK_SUFFIX);
> -    lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 066=
6);
> +    /*
> +     * adjust_shared_perm() will widen permissions if needed,
> +     * otherwise keep permissions restrictive
> +     *
> +     */
> +    if (!stat(path, &st))
> +        mode =3D st.st_mode & 07777;
> +
> +    lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, mod=
e);

I think this change is separate from the changes made in this series,
and needs its own justification (i.e., it's not immediately obvious to
me whether the change is an improvement). Would you mind submitting it
as a separate patch?

>      if (lk->fd < 0) {
>          strbuf_reset(&lk->filename);
>          return -1;
> @@ -268,7 +293,7 @@ int close_lock_file(struct lock_file *lk)
>      return close(fd);
>  }
> =20
> -int reopen_lock_file(struct lock_file *lk)
> +int reopen_lock_file_UNUSED_CAN_IT_BE_REMOVED(struct lock_file *lk)

Junio added this function recently, without any callers, in 93dcaea2. I
assume he has some diabolical plan for it. Junio?

>  {
>      if (0 <=3D lk->fd)
>          die(_("BUG: reopen a lockfile that is still open"));
> @@ -283,7 +308,7 @@ int commit_lock_file_to(struct lock_file *lk, con=
st char *path)
>      int save_errno;
> =20
>      if (!lk->active)
> -        die("BUG: attempt to commit unlocked object");
> +        die("BUG: attempt to commit unlocked object %s", path);

OK.

> =20
>      if (lk->fd >=3D 0 && close_lock_file(lk))
>          goto rollback;
> @@ -325,10 +350,12 @@ void rollback_lock_file(struct lock_file *lk)
>  {
>      if (!lk->active)
>          return;
> +    lk->active =3D 0; /* We are going to de-activate,
> +                       so active is no longer valid already here ? *=
/

I think the question is: what should happen if a signal arrives at this
moment? If we set active=3D0 here, then the signal handler wouldn't cle=
an
up this lockfile at all. But we haven't removed it yet, either. So the
lockfile would get left behind.

So how much longer can we leave active set here?

> =20
>      if (lk->fd >=3D 0)
>          close_lock_file(lk);

close_lock_file() is careful to clear lk->fd *before* closing it, so it
shouldn't be possible for the file to get closed twice [1]. Therefore I
think it is OK to leave lk->active set during the call to close_lock_fi=
le().

>      unlink_or_warn(lk->filename.buf);

This line is a bit dangerous. If we call unlink_or_warn() with
lk->active set, then there is a chance that unlink_and_warn() will be
called a second time by a signal handler that runs after this line but
before lk->active is cleared. The first call would delete the lockfile
that we created, but the second call (which might be delayed for a bit
while our signal handler works its way through the lockfile linked-list=
)
might end up deleting a lockfile that another process created between
our two calls. That would be a bad outcome, but it requires a double
coincidence: our process has to receive a signal at this pessimal momen=
t
*and* another process has to create a lockfile after that event but
before our signal handler has run. And for *real* damage to occur, a
*third* process has to incorrectly acquire the *same* lockfile because
of its incorrect deletion by our process, and it has to make a change
that conflicts with the change that the second process is trying to mak=
e.

On the other hand, if we clear lk->active *before* calling
unlink_or_warn(), then the danger is that we receive a signal and never
clean up the lockfile. The result is perhaps not as bad as deleting
another process's lockfile, but it seems to me that it is far more
likely: it can happen regardless of whether another process is racing
with us, let alone a third process is trying to acquire the same lock.

Can anybody think of a reasonable way to make this 100% safe?

If not, I think the code as written is safer than your proposed change.

> -    lk->active =3D 0;
> +    //lk->active =3D 0;
>      strbuf_reset(&lk->filename);
>  }
>=20
>=20

Thanks very much for your feedback!

Michael

[1] Another question (and I think somebody else brought it up) is
whether close_lock_file() should actually close the file *before*
clearing lk->fd. I will address that question elsewhere.

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
