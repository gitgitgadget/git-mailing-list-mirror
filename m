From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: gc.auto bug in 1.6.5.7
Date: Wed, 6 Jan 2010 16:27:15 -0600
Message-ID: <cccedfc61001061427k6dcb35bcw9f5b5ae0aaf52786@mail.gmail.com>
References: <cccedfc61001060959h72a07eb6g78f2ca231867df63@mail.gmail.com> 
	<u1EMnFha7hfr0SI0p8dEvAJML7vykSCAA6YzQd7klvze6oKChlMCLg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 06 23:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSeM5-0008BP-IS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 23:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab0AFW1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755955Ab0AFW1h
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 17:27:37 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:39359 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab0AFW1g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 17:27:36 -0500
Received: by ey-out-2122.google.com with SMTP id 22so792016eye.19
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 14:27:35 -0800 (PST)
Received: by 10.216.89.84 with SMTP id b62mr87410wef.227.1262816855191; Wed, 
	06 Jan 2010 14:27:35 -0800 (PST)
In-Reply-To: <u1EMnFha7hfr0SI0p8dEvAJML7vykSCAA6YzQd7klvze6oKChlMCLg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136305>

On Wed, Jan 6, 2010 at 12:31 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Jon Nelson wrote:
>> It would appear that there is a bug in git, at least as of 1.6.5.7, =
in
>> the gc command.
>> When gc.auto is non-zero, it appears to consider packfiles as "loose=
"
>> - this conflicts with pack.packSizeLimit, insofar as I have
>> pack.packSizeLimit set to 2M (which appears to work). =A0If gc.auto =
is,
>> say, 50 - once I exceed 50 2MB packs then gc --auto repacks *every
>> single time* it is run. This is unexpected, at least.
>
> There is also a gc.autopacklimit which controls auto-gc'ing based on
> the number of packs. =A0The default is 50 and it does not consider th=
e
> pack.packSizeLimit setting when deciding whether or not to auto-gc.
> It can be raised, or it can be disabled by setting it to zero.

I disabled it entirely and that seemed to resolve the issue.  Thanks!


--=20
Jon
