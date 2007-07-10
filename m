From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: I used git pull instead of stg pull !
Date: Tue, 10 Jul 2007 16:20:08 +0200
Message-ID: <46939598.9000103@eclis.ch>
References: <469356EF.201@eclis.ch> <20070710132957.GA9297@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GaS-0002dB-VR
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbXGJOVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Jul 2007 10:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbXGJOVG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:21:06 -0400
Received: from www.eclis.ch ([144.85.15.72]:58635 "EHLO mail.eclis.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbXGJOVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:21:05 -0400
Received: from [10.192.57.55] (pub1.heig-vd.ch [193.134.216.2])
	by mail.eclis.ch (Postfix) with ESMTP id F1A2D3F215C;
	Tue, 10 Jul 2007 16:20:28 +0200 (CEST)
User-Agent: IceDove 1.5.0.12 (X11/20070606)
In-Reply-To: <20070710132957.GA9297@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52079>

Thanks a lot Karl,

Your method solved the problem perfectly.

Have a good day,
--
Jean-Christian de Rivaz

Karl Hasselstr=F6m a =E9crit :
> On 2007-07-10 11:52:47 +0200, Jean-Christian de Rivaz wrote:
>=20
>> I have made the error to use the "git pull" command instead of the
>> "stg pull" command. The "git pull" have been executed successfuly,
>> but now stg seem to be confused:
>>
>> stg pull -n
>> stg pull: local changes in the tree. Use "refresh" to commit them
>>
>> stg new dummy -m "dummy"
>> stg new: HEAD and top are not the same. You probably committed
>>   changes to the tree outside of StGIT. If you know what you
>>   are doing, use the "refresh -f" command
>>
>> How can I restore the archive to a normal state for stg ?
>=20
> The problem is that you have committed a merge on top of the StGIT
> stack, and StGIT can't deal with that. You can undo the merge
> (provided that you haven't committed anything else on top of it) with
> "git reset --hard HEAD^".
>=20
>   NOTE: "reset --hard" will erase uncommitted modifications to workin=
g
>   tree files, so first make sure that "git status" doesn't report any
>   modifications you want to keep.
>=20
> If you want to get a better view of what it is you're doing, you coul=
d
> fire up gitk and find the sha1 of the commit that is supposed to be a=
t
> the top of the StGIT stack, and "git reset <sha1>" to that commit.
>=20
> Once the merge is undone, just "stg pull" like you wanted to do in th=
e
> first place.
>=20
