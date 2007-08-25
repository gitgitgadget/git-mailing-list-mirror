From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Sat, 25 Aug 2007 09:16:30 +0300
Message-ID: <1529CBA9-860C-464D-AC78-BF75D0196894@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi> <20070823203246.GB3516@steel.home> <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi> <7v8x81s7d1.fsf@gitster.siamese.dyndns.org> <fann62$f5q$2@sea.gmane.org> <7v7inkcz2o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOoxZ-000884-VA
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 08:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbXHYGRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 25 Aug 2007 02:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbXHYGRW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 02:17:22 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:54894 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbXHYGRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2007 02:17:22 -0400
Received: from [10.0.1.2] (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 8A8A21396D2;
	Sat, 25 Aug 2007 09:17:16 +0300 (EEST)
In-Reply-To: <7v7inkcz2o.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56622>


On Aug 25, 2007, at 02:06, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> I think the latter is more important point.  If you train a
>>> naive user to use --only-tracked to ignore "Untracked" list, you
>>> are doing him or her a great disservice.  Mistake to forget "git
>>> add" a new file before commiting will bound to happen.
>>
>> If it won't acquire short version, nor tab completion, mosts users =20
>> when
>> confronted with such a mothful of option-name wouldn't use it unless
>> necessary, I think...
>
> Yeah, but if we accept that --only-tracked patch, I know from
> the past experience that people would send a "shorter synonym"
> patch, arguing that the capability is already there.
>
> I really think we should resist temptation to add misfeatures
> that would encourage bad workflows and new user mistakes.

I really do think that there is a use case for this patch. But this =20
assumes that the testing is done in the source tree, but maybe that =20
in itself can be considered a bad workflow.

An example would be in game development, where I have a directory =20
full of images, and I wish to try out different images in the place =20
of one. I usually create different versions of the images with =20
different names, filling up the image directory under VCS. This =20
usually results in tens of images that will not be tracked (unless =20
they replace the original images), but because of my bad habit of =20
creating the files inside the source tree, which results in a little =20
bit faster workflow for me. With all these untracked files, git-=20
status will obscure the actual contents of the status I wish to see.

I cannot put those files inside .gitignore, as there would have to be =20
some kind of exclusion pattern for them that won't match the tracked =20
files. Sure I could prefix all of my test images with 'test_' or =20
something similiar. Or I could just add '*' to .gitignore, and force =20
adds. The latter seems like a bad habit for me, the other seems to =20
include a lot of manual labor, especially when someone else sends =20
test files for me.

So the end result for me is, that it's easier to use --only-tracked

=46ringe case? Maybe. Workflow could be better, sure. But --only-=20
tracked even works for the less technical folk, which might be scared =20
of forcing the changes, or annoyed by having to name the files with a =20
magic prefix.

--
V=E4in=F6
