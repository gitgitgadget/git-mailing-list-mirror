From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 17:48:32 +0100
Message-ID: <86r6gbi0pr.fsf@lola.quinscape.zz>
References: <478E1FED.5010801@web.de>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	<478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801 171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 17:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGzpe-0000wI-2T
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYAUQsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836AbYAUQsl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:48:41 -0500
Received: from main.gmane.org ([80.91.229.2]:35171 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbYAUQsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:48:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JGzp7-0006Mb-Rb
	for git@vger.kernel.org; Mon, 21 Jan 2008 16:48:37 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 16:48:37 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 16:48:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:Mlqrm5O6F5//Pl/YhZBqYVZ/N8Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71293>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
>
>> I happen to prefer the text-as-string-of-characters (or code points,
>> since you use the other meaning of characters in your posts), since =
I
>> come from the text world, having worked a lot on Unicode text
>> processing.
>>
>> You apparently prefer the text-as-sequence-of-octets, which I tend t=
o
>> dislike because I would have thought computer engineers would have
>> evolved beyond this when we left the 1900s.
>
> I agree. Every single problem that I can recall Linus bringing up as =
a
> consequence of HFS+ treating filenames as strings is in fact only a
> problem if you then think of the filename as octets at some point. If
> you stick with UTF-8 equivalence comparison the entire time, then
> everything just works.

git calculates hashes over filenames and sorts them.  This is not a mer=
e
question of "UTF-8 equivalence comparison".

> Granted, this is a problem when you have to operate on a filesystem
> that thinks of filenames as octets,

It also is a problem when operating on a filesystem that considers "=E4=
" a
single utf-8 character instead of decomposing it.

> but as I said before, this doesn't mean the HFS+ approach is wrong, i=
t
> just means it's incompatible with Linus's approach.

It is not the business of a file system to juggle with filename
representations.

--=20
David Kastrup
