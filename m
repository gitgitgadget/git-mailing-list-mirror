From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Fri, 21 Dec 2012 09:11:08 +0100
Message-ID: <50D4199C.6000002@alum.mit.edu>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 09:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlxha-00023I-V9
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 09:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab2LUILO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 03:11:14 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58427 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751168Ab2LUILM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 03:11:12 -0500
X-AuditID: 12074411-b7fa36d0000008cc-64-50d4199f7220
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 36.C3.02252.F9914D05; Fri, 21 Dec 2012 03:11:11 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBL8B8Ds028714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 03:11:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121220215638.E54BC44119@snark.thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqDtf8kqAwZQ/UhZXt/hYdF3pZnJg
	8lj2tZPF4/MmuQCmKG6bpMSSsuDM9Dx9uwTujH9f77AVLOOqmHe/g7mBcT1HFyMnh4SAiUTX
	tCVsELaYxIV764FsLg4hgcuMEp8adjFDOMeZJLb9msDYxcjBwSugLTHjqAKIySKgKvH3TQBI
	L5uArsSinmYmEFtUIEBi8ZJz7CA2r4CgxMmZT1hAbBEBdYkPR44yg7QyC4hL9P8DCwsLuEts
	27mPGcQWErCUmDDpHdg5nAJWEqs6JoGNZBbQkXjX94AZwpaX2P52DvMERoFZSDbMQlI2C0nZ
	AkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghISq4g3HGSblDjAIcjEo8
	vJEWlwOEWBPLiitzDzFKcjApifLOF7kSIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEl+krUDlv
	SmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYI3SwJoqGBRanpqRVpmTglC
	momDE2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2nscpJ23uCAxFygK0XqKUZfjVsPNp4xC
	LHn5ealS4rwbQYoEQIoySvPgVsAS0itGcaCPhXnPgVTxAJMZ3KRXQEuYgJYE6V0AWVKSiJCS
	amAM3WmtdVS87top3paLyRuuB3D3Xm5e2Wi4cnNDLUPmnPtSYUU7bidyJ08LWnZ/QnPuFYYX
	d6t4CnUltGOtrBrux3y99mNNNNPHkhjbvi3euWdt5fPyclfdztkg+MuoPo7vUfpU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211957>

On 12/20/2012 10:56 PM, Eric S. Raymond wrote:
> Earlier today David Mansfield handed off to me the cvsps project. This
> is the code used as an engine for reading CVS repositories by
> git-cvsimport.
> [...] I have added a --fast-export option to
> cvsps-3.0 that emits a git fast-import stream representing the CVS
> history.
> [...]
> Possibly it fixes some other problems described there as well.  
> I don't understand all the bug warnings on that page and would like to
> discuss them with the author, whoever that is.  Possibly cvsps can be
> further enhanced to address these problems; I'm willing to work on that.

In 2009 I added tests demonstrating some of the erroneous behavior of
git-cvsimport.  The failing tests in t9601-t9603 are concrete examples
of the problems mentioned in the manpage.

If you haven't yet seen it, there is a writeup of the algorithm used by
cvs2git to infer the history of a CVS repository [1].  If your goal is
to make cvsps more robust, you might want to consider the ideas
described there.

Michael

[1] File doc/design-notes.txt in the cvs2svn source tree, also visible here:


http://cvs2svn.tigris.org/source/browse/*checkout*/cvs2svn/trunk/doc/design-notes.txt

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
