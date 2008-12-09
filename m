From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: git-bpush: Pushing to a bundle
Date: Tue, 9 Dec 2008 11:21:36 +0100
Message-ID: <adf1fd3d0812090221t2264a4f9i87b5e23be897ee84@mail.gmail.com>
References: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
	 <alpine.DEB.1.00.0812091100470.2916@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zk2-0003tn-Bm
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbYLIKVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 05:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbYLIKVj
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:21:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:26802 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYLIKVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 05:21:38 -0500
Received: by nf-out-0910.google.com with SMTP id d3so775180nfc.21
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 02:21:37 -0800 (PST)
Received: by 10.103.191.12 with SMTP id t12mr1636039mup.49.1228818096767;
        Tue, 09 Dec 2008 02:21:36 -0800 (PST)
Received: by 10.103.167.6 with HTTP; Tue, 9 Dec 2008 02:21:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812091100470.2916@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102622>

=46irst, thanks for the comments.

2008/12/9 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Tue, 9 Dec 2008, Santi B=E9jar wrote:
>
>> The basic idea is:
>>
>> - Easily create bundles with the current branch.
>> - Be able to push to defined bundles in remote.<remote>.url
>> - Only add new objects by default (do not lose objects)
>
> That is probably not what people need.  Usually, when bundles are sen=
t
> around, you need _incremental_ bundles.

I do not find convenient strictly incremental bundles, because then
you (or the other people) needs to fetch every single bundle. What I
do is add new objects until the bundle is too big and then create a
bundle with a new base. This way you don't have to worry if the other
person has applied the last bundle or not.

>  IOW if you already have a bundle,
> you want to create a new bundle that contains everything that is new,=
 _in
> addition_ to the existing bundle.

>> while [ $# !=3D 0 ] ; do
>
> Heh, I did not realize just how _used_ I got to the conventions in Gi=
t's
> shell programming, until I thought "Should this not use 'test' instea=
d
> of brackets?"

I don't have problems either way, I'll change to follow Git's conventio=
ns.

>
>> while [ $# !=3D 0 ] ; do
>>     refs=3D"$refs$LF$1" && shift
>> done
>
> That is equivalent to refs=3D"$*", no?

Almost, IFS is set to line-feed so I needed to put $LF instead of space=
s.

>
> Anyway, I found reading your shell script quite hard, because of exce=
ssive
> use of brackets and single line && chains (which lack proper error
> handling, BTW).

I've tried to catch errors, but maybe not enough.

Santi
