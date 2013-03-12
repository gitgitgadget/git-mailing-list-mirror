From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Tue, 12 Mar 2013 01:15:56 +0100
Message-ID: <C53F5B74-C634-461A-B9AA-B6B5A4310B43@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com> <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de> <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com> <E30ECECD-DD58-41E2-AA7C-18F83E5E74E6@quendi.de> <CADgNja=QJpe2nmqKn9rR1os=zjjqK+dWA+ZLaJA4pgLG8tVgzg@mail.gmail.com> <ED1442D4-C011-49F3-928C-0BE0280F7D42@quendi.de> <CADgNja=oyAVVNTAY-OG5
 U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: multipart/mixed; boundary="Apple-Mail=_741474C6-6ADA-4634-AAF9-59774BD1164D"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 01:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFCtz-0002fu-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 01:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab3CLAQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 20:16:44 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:49196 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754415Ab3CLAQo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 20:16:44 -0400
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Tue, 12 Mar 2013 01:16:37 +0100
Received: from merkur.hrz.uni-giessen.de (merkur.hrz.uni-giessen.de [134.176.2.12])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id 9A1764800093;
	Tue, 12 Mar 2013 01:15:57 +0100 (CET)
Received: from [134.176.2.12] by merkur.hrz.uni-giessen.de with ESMTP; Tue, 12 Mar 2013 01:15:57 +0100
In-Reply-To: <CADgNja=oyAVVNTAY-OG5U2gmoYGdpUGDVKvDb4EdD2Q+9KgDcw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217925>


--Apple-Mail=_741474C6-6ADA-4634-AAF9-59774BD1164D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1


On 11.03.2013, at 23:54, Andrew Wong wrote:

> On 3/11/13, Max Horn <max@quendi.de> wrote:
>> Looking at the git config man page to check what each of my config =
settings
>> does, I discovered "trustctime". And adding
>> 	trustctime =3D false
>> to .git/config made the rebase work, every single time. Huh.
>>=20
>>=20
>> Adding this to the fact that a clone works fine, I wonder if  =
something *is*
>> touching my files, but just in that directory. But what could it be? =
One
>> nagging suspicion is the "file versioning" feature Apple introduced =
as part
>> of Time Machine in OS X 10.7; it's kind of a "version control system =
for
>> n00bs" for arbitrary documents. It has caused me some pain in the =
past.
>>=20
>> But I just re-checked, and problematic repos is explicitly on the =
Time
>> Machine exclusion list. I also used the "tmutil isexcluded FILES" to =
verify
>> that the problematic files are really on the TM exclusion list. =
Finally, I
>> moved the one of the repos subdirectory containing most of the =
problematic
>> files, and then run "git checkout". In other instances, this sufficed =
to
>> "disassociate" a file from an unwanted TM version history. But doing =
that
>> had no effect here, i.e. also with the freshly regenerated files, the
>> problems appear.
>=20
> Would you be able to turn off Time Machine completely and do a few
> tests? If it does works, then it becomes a matter of fixing Time
> Machine...

I did turn it off just now, but no effect. Then again, daemons like =
revisiond were still running...


One more thing: I used the "fs_usage" to monitor what process accessed =
what file during one of those failing "git rebase" runs. I then searched =
through this to determine which processes accessed the "bad" file in =
this time. The result where these processes (aggregated):

  git
  revisiond
  fseventsd
  git-merge-recursive

Note that Time Machine was not running, but revisiond is... from its =
manpage:

     revisiond is the daemon that manages document revisions created by =
applications and system services.

     There are no configurations to revisiond, and users should not run =
revisiond manually.

This is the process I am suspecting. Specifically, a fchflags call it =
makes (see that attached excerpt of the fs_usage output). I am not sure, =
but my guess would be that it sets SF_ARCHIVED on the file. Causing its =
ctime to wander... Yuck.

But I don't know how to control it... and I am not sure if I can just =
kill it. Hrm. I'll try to dig some more into it, perhaps I can somehow =
confirm that this is *really* the cause of the problems, and somehow =
prevent it.


Cheers,
Max


--Apple-Mail=_741474C6-6ADA-4634-AAF9-59774BD1164D
Content-Disposition: attachment;
	filename=git-rebase-debug.txt
Content-Type: text/plain;
	name="git-rebase-debug.txt"
Content-Transfer-Encoding: quoted-printable

00:59:54.349156  lstat64                                src/BAD_FILE     =
                                        0.000050   git.623953
00:59:54.349160  open              F=3D5        (R_____)  src/BAD_FILE   =
                                          0.000004   git.623953
00:59:54.350659  close             F=3D5                                 =
                                          0.000007   git.623953
00:59:54.371716  lstat64                                src/BAD_FILE     =
                                        0.000002   git.623955
00:59:54.429674  lstat64                                src/BAD_FILE     =
                                        0.000002   git.623959
00:59:54.600060  lstat64                                src/BAD_FILE     =
                                        0.000007   git.623959
00:59:54.600151  stat64                                 =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000006   =
revisiond.623963
00:59:54.600154  stat64                                 =
/Users/mhorn/the-path-to-my-repository/src               0.000003   =
revisiond.623963
00:59:54.600160  open              F=3D7        (R_____)  =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000006   =
revisiond.623963
00:59:54.600161  fstatfs64         F=3D7                                 =
                                          0.000002   revisiond.623963
00:59:54.600163  close             F=3D7                                 =
                                          0.000002   revisiond.623963
00:59:54.600387  unlink                                 src/BAD_FILE     =
                                        0.000328 W git.623959
00:59:54.600429  open              F=3D5        (_WC__E)  src/BAD_FILE   =
                                          0.000039   git.623959
00:59:54.602910  write             F=3D5    B=3D0x4000                   =
                                            0.000040   git.623959
00:59:54.602932  write             F=3D5    B=3D0x4000                   =
                                            0.000017   git.623959
00:59:54.602947  write             F=3D5    B=3D0x4000                   =
                                            0.000011   git.623959
00:59:54.602958  write             F=3D5    B=3D0x4000                   =
                                            0.000009   git.623959
00:59:54.602969  write             F=3D5    B=3D0x4000                   =
                                            0.000009   git.623959
00:59:54.602977  write             F=3D5    B=3D0x12f5                   =
                                            0.000007   git.623959
00:59:54.602983  fstat64           F=3D5                                 =
                                          0.000004   git.623959
00:59:54.603032  close             F=3D5                                 =
                                          0.000049   git.623959
00:59:54.621731  lstat64                                =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000004   =
fseventsd.1664
00:59:54.882870  lstat64                                src/BAD_FILE     =
                                        0.000002   git.623993
00:59:54.882872  open              F=3D5        (R_____)  src/BAD_FILE   =
                                          0.000003   git.623993
00:59:54.883042  close             F=3D5                                 =
                                          0.000002   git.623993
00:59:55.021956  lstat64                                src/BAD_FILE     =
                                        0.000003   git.624027
00:59:55.021959  open              F=3D4        (R_____)  src/BAD_FILE   =
                                          0.000003   git.624027
00:59:55.022138  close             F=3D4                                 =
                                          0.000003   git.624027
00:59:56.600440  open              F=3D7        (R_____)  =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000014   =
revisiond.623963
00:59:56.600442  fcntl             F=3D7   <GETPATH>                     =
                                          0.000002   revisiond.623963
00:59:56.600445  close             F=3D7                                 =
                                          0.000004   revisiond.623963
00:59:56.600449  stat64                                 =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000004   =
revisiond.623963
00:59:56.600452  stat64                                 =
/Users/mhorn/the-path-to-my-repository/src               0.000003   =
revisiond.623963
00:59:56.600455  open              F=3D7        (R_____)  =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000004   =
revisiond.623963
00:59:56.600457  fstatfs64         F=3D7                                 =
                                          0.000002   revisiond.623963
00:59:56.600459  close             F=3D7                                 =
                                          0.000002   revisiond.623963
00:59:56.600687  open              F=3D7        (R_____)  =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000006   =
revisiond.623963
00:59:56.600688  fstat64           F=3D7                                 =
                                          0.000002   revisiond.623963
00:59:56.600698  fchflags          F=3D7   <UNKNOWN>       [garbled =
output removed]                                0.000010   =
revisiond.623963
00:59:56.600701  close             F=3D7                                 =
                                          0.000003   revisiond.623963
00:59:56.624161  lstat64                                =
/Users/mhorn/the-path-to-my-repository/src/BAD_FILE      0.000004   =
fseventsd.1664
00:59:56.981172  lstat64                                src/BAD_FILE     =
                                        0.000004   git.624517
00:59:57.015622  lstat64                                src/BAD_FILE     =
                                        0.000005   git.624527
00:59:57.118844  lstat64                                src/BAD_FILE     =
                                        0.000005   =
git-merge-recurs.624544
01:00:00.194634  lstat64                                src/BAD_FILE     =
                                        0.000002   git.624580
01:00:00.194637  open              F=3D5        (R_____)  src/BAD_FILE   =
                                          0.000003   git.624580
01:00:00.194815  close             F=3D5                                 =
                                          0.000003   git.624580

--Apple-Mail=_741474C6-6ADA-4634-AAF9-59774BD1164D--
