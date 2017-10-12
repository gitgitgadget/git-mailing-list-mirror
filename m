Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98121FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 05:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdJLFbg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 01:31:36 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:42064 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750758AbdJLFbf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 01:31:35 -0400
Received: from resomta-po-11v.sys.comcast.net ([96.114.154.235])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id 2W5ne7rS5bjnM2W5neXQEs; Thu, 12 Oct 2017 05:31:35 +0000
Received: from mail.tremily.us ([67.168.186.5])
        by resomta-po-11v.sys.comcast.net with SMTP
        id 2W3qe9KkVsmO32W3qeKC2c; Thu, 12 Oct 2017 05:29:35 +0000
Received: by mail.tremily.us (Postfix, from userid 1000)
        id 29E52FED23A; Wed, 11 Oct 2017 22:30:02 -0700 (PDT)
Date:   Wed, 11 Oct 2017 22:30:02 -0700
From:   "W. Trevor King" <wking@tremily.us>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
Message-ID: <20171012053002.GZ11004@valgrind.tremily.us>
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
 <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1IWgL8yD8uKyf/Tu"
Content-Disposition: inline
In-Reply-To: <xmqqefq92mgw.fsf@gitster.mtv.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfDfHnHbDDtdAvZ8NEdSBZCd6bcYxZywPQjZyXcDWu7577IuIIEGtJjrHj7KKTPUxAcq6qd9rFk7UXrYgtabYgScTZKfDAZF1+bfwYRv+lHLF1Ms7bhe0
 McSiEOKKpks7TteYoit6ngohmCqN/Wmrk+Z70APy6oV3fUw2ZDmAEaCoBus052m3SP1Jk14SmLtf3C/mS7eZJtJ21d6Je0ENwXeZefIcuECkcG40GH25RrwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1IWgL8yD8uKyf/Tu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 10:17:51AM +0900, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > Following 09c2cb87 (pull: pass --allow-unrelated-histories to "git
> > merge", 2016-03-18) with the tests also drawing on 14d01b4f (merge:
> > add a --signoff flag, 2017-07-04).
>=20
> I cannot find a verb in the above.

I'd meant it as either a continuation of the subject line, or with an
implicit leading =E2=80=9CI did this=E2=80=A6=E2=80=9D :p.  I can reword if=
 you like, maybe
just =E2=80=9CFollowing=E2=80=9D =E2=86=92 =E2=80=9CFollow=E2=80=9D?  Somet=
hing more drastic?

> > The order of options in merge-options.txt isn't clear to me, but
> > I've put --signoff between --log and --stat as somewhat
> > alphabetized and having an "add to the commit message" function
> > like --log.
> >
> > The tests aren't as extensive as t7614-merge-signoff.sh, but they
> > exercises both the --signoff and --no-signoff options.  There may
> > be a more efficient way to set them up (like
> > t7614-merge-signoff.sh's test_setup), but with all the pull
> > options packed into a single test script it seemed easiest to just
> > copy/paste the duplicate setup code.
>
> The above two paragraphs read more like "requesting help for hints
> to improve this patch" than commit log message.  Perhaps move them
> below the three-dash line and instead describe what you actually did
> here (if they were worth explaining, that is)?

I think something about merge-options.txt ordering should end up in
the history of that content.  Reading through:

  $ git log Documentation/merge-options.txt

only turned up 690b2975 (Documentation/merge-options.txt: group "ff"
related options together, 2012-02-22) discussing option order (it
suggested grouping similar options together, although --ff and
--ff-only would also be close alphabetically).

I agree that the first paragraph you quote above doesn't have me
coming down firmly in favor of a particular ordering strategy, but I
think having something like it in the Git history will help whoever
ends up giving merge-options.txt a well-defined strategy by showing I
didn't have any strong opinions to account for ;).  Silence can mean
=E2=80=9Cdoesn't have a strong opinion=E2=80=9D, but sometimes it means =E2=
=80=9Cfeels the
choice is so obvious that it doesn't need explicit motivation=E2=80=9D.

I'm fine moving the second paragraph you quote below the fold in a v2,
although you're calling for more tests below, and it won't apply
anymore once I've added those :).

> > 09c2cb87 didn't motivate the addition of --allow-unrelated-histories
> > to pull; only citing the reason from e379fdf3 (merge: refuse to create
> > too cool a merge by default, 2016-03-18) gave for *not* including it.
> > I like having both exposed in pull because while the fetch-and-merge
> > approach might be a more popular way to judge "how well they fit
> > together", you can also do that after an optimistic pull.  And in
> > cases where an optimistic pull is likely to succeed, suggesting it is
> > easier to explain to Git newbies than a FETCH_HEAD merge.
>=20
> I find this paragraph totally unrelated to what the patch does.
> Save it for the patch you add to pass --allow-unrelated-histories
> given to pull down to underlying merge, perhaps?

09c2cb87 is your commit in master (v2.9.0-rc0~88^2) that is doing just
that.  I haven't gone through the list history to figure out why it
ended up getting landed with its current commit message; =E2=80=9CPrepare a
patch to make it a reality, just in case it is needed=E2=80=9D sounds more
like it was =E2=80=9Chere's the code in case folks want it, I'll reroll the
motivation if they do=E2=80=9D.  This paragraph was aiming to motivate both
the --signoff pass-through I'm adding here and (retroactively) the
--allow-unrelated-histories pass-through you added there.  I'll add
more context in v2 to try to make that more clear.

> > +	cat >expected <<-EOF &&
> > +		Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> > +	EOF
>=20
> 	echo "Signed-off-by: $GIT_COMMITER_NAME <$GIT_COMMITTER_EMAIL>" >expect

Much nicer, thanks.  I'll add a patch to v2 to make the same change to
t7614.

> > +	git init src &&
> > +	(
> > +		cd src &&
> > +		test_commit one
> > +	) &&
>=20
> I suspect somebody will suggest "test_commit -C" ;-)

Sounds good.  I'll add a patch to v2 to make the same change to the
existing t5521 --allow-unrelated-histories test.

> > +	git clone src dst &&
> > +	(
> > +		cd src &&
> > +		test_commit two
> > +	) &&
> > +	(
> > +		cd dst &&
> > +		git pull --signoff --no-ff &&
> > +		git cat-file commit HEAD | tail -n1 >../actual
>=20
> I think it makes it more robust to replace "tail" with "collect all
> the signed-off-by lines" like the other test (below) does.  Perhaps
> have a helper function and use it in both?
>=20
> 	get_signoff () {
> 		git cat-file commit "$1" | sed -n -e '/^Signed-off-by: /p'
> 	}
>=20
> Some may say "cat-file can fail, and having it on the LHS of a pipe
> hides its failure", advocating for something like:
>=20
> 	get_signoff () {
> 		git cat-file commit "$1" >sign-off-temp &&
> 		sed -n -e '/^Signed-off-by: /p' sign-off-temp
> 	}

There are several existing consumers using grep and sed for this:

  wking@ullr ~/src/git/git $ git grep Signed-off-by v2.15.0-rc1 -- 't/*.sh'=
 | grep 'grep\|sed'
  =E2=80=A6
  v2.15.0-rc1:t/t3501-revert-cherry-pick.sh:      git cat-file commit HEAD =
| grep ^Signed-off-by: >signoff &&
  v2.15.0-rc1:t/t3507-cherry-pick-conflict.sh:    test_i18ngrep -e "Signed-=
off-by" .git/MERGE_MSG
  v2.15.0-rc1:t/t3507-cherry-pick-conflict.sh:    test $(git show -s |grep =
-c "Signed-off-by") =3D 1
  v2.15.0-rc1:t/t3507-cherry-pick-conflict.sh:    grep -e "^# Conflicts:" -=
e '^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
  v2.15.0-rc1:t/t3507-cherry-pick-conflict.sh:    grep -e "^Conflicts:" -e =
'^Signed-off-by' <.git/COMMIT_EDITMSG >actual &&
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    ! grep "Signed-off-by:" i=
nitial_msg &&
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    grep "Signed-off-by:" unr=
elatedpick_msg &&
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    ! grep "Signed-off-by:" p=
icked_msg &&
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    grep "Signed-off-by:" ano=
therpick_msg
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    ! grep Signed-off-by: msg
  v2.15.0-rc1:t/t3510-cherry-pick-sequence.sh:    ! grep Signed-off-by: msg
  v2.15.0-rc1:t/t4014-format-patch.sh:    grep "^Signed-off-by: $GIT_COMMIT=
TER_NAME <$GIT_COMMITTER_EMAIL>" out
  v2.15.0-rc1:t/t4014-format-patch.sh:    ! sed "/^Signed-off-by: /q" out |=
 grep "test message" &&
  v2.15.0-rc1:t/t4014-format-patch.sh:    sed "1,/^Signed-off-by: /d" out |=
 grep "test message" &&
  v2.15.0-rc1:t/t4153-am-resume-override-opts.sh: git cat-file commit HEAD^=
 | grep "Signed-off-by:" >actual &&
  v2.15.0-rc1:t/t4153-am-resume-override-opts.sh: test $(git cat-file commi=
t HEAD | grep -c "Signed-off-by:") -eq 0
  v2.15.0-rc1:t/t7501-commit.sh:          sed -e "s/>.*/>/" -e "s/^/Signed-=
off-by: /"
  v2.15.0-rc1:t/t7501-commit.sh:          sed -e "s/>.*/>/" -e "s/^/Signed-=
off-by: /"
  v2.15.0-rc1:t/t7501-commit.sh:          sed -e "s/>.*/>/" -e "s/^/Signed-=
off-by: /"
  v2.15.0-rc1:t/t7501-commit.sh:          sed -e "s/>.*/>/" -e "s/^/Signed-=
off-by: /"
  v2.15.0-rc1:t/t7502-commit.sh:  actual=3D$(git cat-file commit HEAD | sed=
 -ne "s/Signed-off-by: //p") &&
  v2.15.0-rc1:t/t7614-merge-signoff.sh:Signed-off-by: $(git var GIT_COMMITT=
ER_IDENT | sed -e "s/>.*/>/")

Perhaps we want something like:

  test_has_trailer $OBJECT $TOKEN $VALUE

and:

  test_has_no_trailer $OBJECT $TOKEN

in test-lib-functions.sh that we can use in all of these cases?

> I think "--signoff" and "--signoff --no-signoff" are reasonable
> minimum things to test.  Two more cases, i.e. running it without
> either and with "--no-signoff" alone, to ensure that the sign-off
> mechanism does not kick in would make it even better.

Sounds good, I'll add those in v2.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--1IWgL8yD8uKyf/Tu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpgNNa8H/zemHkt2gprXBz9Wld7YFAlne/bEACgkQprXBz9Wl
d7aURw//fdbn2nayjXA0TILEFd7YYrfXS9IhgtdV7lDkTXdu+SX/ZLacXnULYnJU
wpeBDyRVQtAu0f8T+V8lbz/tVRlg3oTmBihjNGzEYCHpi1eEBBdsARfQQgjSmsJb
TBGf2hiMm/jM66YWcbLvRzMSfwE/xNyIrY2lJUkR4HwTU5hekFIVfdXS20amJiQf
dU9eNtXfEoKUKoGKEe/IWXylb5hZXcVHKJltZVNLJ1uz01HXdXrzDQUlJlymm7Np
nU0HfYn63pWs6iIt/Ik/oXBco/ecFZ71cnE+D89LE+HS/SmBJ+11DvBgrWt2klX0
+L4XE41g7VBBqqy1MMqvXhPToa3/rF4bx8rNaUgXROUENQ+CnAcC4zBCxYoDH3q3
1Yfuc9uK6CyXBO0iOjb1BSJkH+rWv2iYPPp/YyaqrIDr8BQIVn+/x8hvqNda34Se
8fE3/+IvhcXQx7FvaXNrPayAdgPrEBTKVLRAf7kTkh7BmV/9liKNmEznasFzSX4M
MG1jtlAN7bZerOcdZ0XeRSR9bPbCKqKZaSuYuUDroKlgHcYyD5QkdsQFObq5BRkk
PWU7/52oTtkp4avHb5adjokbLELIqIC77qkRUTQQMNeU57p12br7pzbuobKtvhyP
jHNekYMA30/vKXCXBze+ObHzjHA7RcnBu9HfRD5yfEczEPOSCBU=
=8Jxs
-----END PGP SIGNATURE-----

--1IWgL8yD8uKyf/Tu--
