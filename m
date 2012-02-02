From: Beat Bolli <ig@drbeat.li>
Subject: Git-gui: crashes on OS X when entering combining ("dead") keys
Date: Thu, 02 Feb 2012 23:04:12 +0100
Message-ID: <4F2B085C.2000508@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 23:11:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4sU-0004Qs-L8
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492Ab2BBWL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 17:11:29 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:55801 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab2BBWL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 17:11:26 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Feb 2012 17:11:26 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 546D5C34D1
	for <git@vger.kernel.org>; Thu,  2 Feb 2012 23:04:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	MANY_SUBDOM,NORMAL_HTTP_TO_IP autolearn=no version=3.3.2
Received: from mcmini.bolli (6-45-60-212-pool.cable.fcom.ch [212.60.45.6])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 24DBAC34CF
	for <git@vger.kernel.org>; Thu,  2 Feb 2012 23:04:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Enigmail-Version: 1.3.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189716>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I've just had git-gui crash on me when I tried to enter the ~ (tilde)
character on my Mac mini under OS X 10.6.8:

2012-02-02 22:26:25.992 Wish[49140:60f] An uncaught exception was raise=
d
2012-02-02 22:26:25.995 Wish[49140:60f] *** -[NSCFString
characterAtIndex:]: Range or index out of bounds
2012-02-02 22:26:25.996 Wish[49140:60f] *** Terminating app due to
uncaught exception 'NSRangeException', reason: '*** -[NSCFString
characterAtIndex:]: Range or index out of bounds'
*** Call stack at first throw:
(
        0   CoreFoundation                      0x00007fff8273d784
__exceptionPreprocess + 180
        1   libobjc.A.dylib                     0x00007fff87c10f03
objc_exception_throw + 45
        2   CoreFoundation                      0x00007fff8273d5a7
+[NSException raise:format:arguments:] + 103
        3   CoreFoundation                      0x00007fff8273d534
+[NSException raise:format:] + 148
        4   Foundation                          0x00007fff843ec6ad
- -[NSCFString characterAtIndex:] + 97
        5   Tk                                  0x00000001000bdbcf
Tk_SetCaretPos + 663
        6   Tk                                  0x00000001000c3d94
Tk_MacOSXSetupTkNotifier + 699
        7   Tcl                                 0x00000001001c629e
Tcl_DoOneEvent + 297
        8   Tk                                  0x000000010001c080
Tk_MainLoop + 24
        9   Tk                                  0x0000000100028ab4
Tk_MainEx + 1555
        10  Wish                                0x0000000100004545 0x0
+ 4294985029
        11  Wish                                0x00000001000044a4 0x0
+ 4294984868
)
terminate called after throwing an instance of 'NSException'
error: git-gui died of signal 6

[sorry for wrapping]

I use the Swiss German keyboard layout where the tilde is a dead key
on Fn+n (for entering the spanish =F1, I assume). Other dead keys like
=A8, =B4 and ` also cause git-gui to crash. It does not matter whether =
the
dead key is the last one in the commit message or not.

Interestingly, the commit text was saved to .git/COMMIT_MSG in spite
of the crash, so I didn't lose any of it.

I use the current git 1.7.9 installed via homebrew.

Thanks,
Beat Bolli

PS: Please CC me on replies, I'm not on the list. Thanks.
- --=20
pgp: 0x506A903A; 49D5 794A EA77 F907 764F  D89E 304B 93CF 506A 903A
gsm: 4.7.7.6.0.7.7.9.7.1.4.e164.arpa
icbm: 47.0452 N, 7.2715 E

"It takes love over gold, and mind over matter" -- Dire Straits
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8rCFwACgkQMEuTz1BqkDoMhwCfZr+/FAsl7LsVxxHmelirDh+w
RZsAoOzusVol5b8zZEGq9NLanHlfi4bt
=3DhFrL
-----END PGP SIGNATURE-----
