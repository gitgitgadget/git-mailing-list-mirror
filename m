From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: retrospective move
Date: Wed, 4 Feb 2009 13:57:55 +0100
Message-ID: <adf1fd3d0902040457p7823792dg80a6d389f8079c32@mail.gmail.com>
References: <21826423.post@talk.nabble.com>
	 <200902041017.47564.trast@student.ethz.ch>
	 <adf1fd3d0902040231h2fb6f199oee143e36a7501a2a@mail.gmail.com>
	 <200902041333.40776.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jemmyw <jeremy@boost.co.nz>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 04 14:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhMl-0008AX-IM
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 14:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555AbZBDM6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758548AbZBDM6A
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:58:00 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:40641 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543AbZBDM56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:57:58 -0500
Received: by ewy14 with SMTP id 14so3244692ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 04:57:56 -0800 (PST)
Received: by 10.103.198.15 with SMTP id a15mr912719muq.60.1233752275567; Wed, 
	04 Feb 2009 04:57:55 -0800 (PST)
In-Reply-To: <200902041333.40776.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108360>

2009/2/4 Thomas Rast <trast@student.ethz.ch>:

[...]

>
> Here's a sequence of commands that makes a test case:
>
>  git init
>  seq 1 10 > A
>  git add A
>  git commit -m initial
>  seq 11 15 >> A
>  git commit -m second A
>  seq 16 20 >> A
>  git commit -m third
>  git checkout -b side HEAD~2
>  cp A B
>  git add B
>  git commit -m copy
>  seq 3 10 > B               # <--
>  git commit -m edit B
>  git rm A
>  git commit -m delete
>
> Then running
>
>  git merge master
>
> goes through cleanly, but changing the line indicated above to 'seq 5
> 10' makes it less similar, falling through the detection and causing a
> conflict.

Thanks, but that's known, this is why I wrote "or the files are
small". I was not clear, but what I wanted was a *real* test case. In
which cases this is a problem in practice.

>  The minimum required similarity for merges does not seem to
> be configurable unfortunately.

No, but nevertheless it works fine most of the time, except with small files.

HTH,
Santi
