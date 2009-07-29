From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 10:41:01 +0200
Message-ID: <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4in-0007tZ-CK
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbZG2IlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 04:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZG2IlC
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:41:02 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:39569 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZG2IlB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:41:01 -0400
Received: by ewy26 with SMTP id 26so645447ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:41:01 -0700 (PDT)
Received: by 10.216.52.76 with SMTP id d54mr2357468wec.119.1248856861046; Wed, 
	29 Jul 2009 01:41:01 -0700 (PDT)
In-Reply-To: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124327>

2009/7/29 demerphq <demerphq@gmail.com>:
> I was wondering if anybody had any suggestions on a sane way to add a
> file to a git-archive when it is being produced.
>
> For =A0instance build procedures that expect to be run inside of a gi=
t
> WD wont work if built from an archived version of the tree. Being abl=
e
> to provide a file of additional data to the archive package would be =
a
> very convenient way to work around this.
>
> Ideally id like to be able to specify a set of additional files to
> include in the archive as part of the git-archive command line
> interface, but I'd be nearly as a happy with almost any solution othe=
r
> than the one I came up with, which is to use archive to generate a ta=
r
> file, then use tar to append the additional files to the tar, and the=
n
> compress it. This process turns out to be quite slow in comparison to
> producing a compressed archive directly from git-archive.

Then I don't know. It is exactly the way it is done in git.git itself,
look the dist target in the makefile.

>
> Another question is whether anyone has any advice on the best way to
> find out the "best" branch an arbitrary commit is on. Where best can
> be flexibly definied to handle commits that are reachable from
> multiple branches. =A0I have hacked a solution involving git-log and
> grep, but it performs quite poorly. I was wondering if there is a
> better solution.

The "best" tag is easy: git describe commit. For branches I think you
could use "git name-ref --refs=3Drefs/heads/* commit", because git
describe does not have a --branches flag.

HTH,
Santi
