From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 1 Mar 2007 12:40:50 +1300
Message-ID: <46a038f90702281540o520cc214xa929a3e3c4e70883@mail.gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	 <200702271345.09341.andyparkins@gmail.com>
	 <46a038f90702280336k6d368b8aj88ce8d3d822b1789@mail.gmail.com>
	 <200702281301.58026.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 00:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMYQU-0000Pv-Ry
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 00:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbXB1Xkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 18:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXB1Xkx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 18:40:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:8023 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425AbXB1Xkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 18:40:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so713612nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 15:40:50 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F4IHesuEYr7bhCvp2aNiCULxZ60PLJrAxS5fUQDPdAPCOAZeDYmfvnUj6NWx0REkwCiPTWTGRjmbOkmmHDngEtHBPhF5BtQIHqGA3Ed8XjACHWe4SGt9K5GwB+9SfQp/SgRU9b8UoDsBa+QfkAESuKJ8/20GSWIbjQOLFySMQNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EGL8BI7KJK1g79w9rxRVzmwdp/kDMr1B5MlOzDLxbJ9IFlWFEsyY0VEsjNsnaQseNrJhgXP49wDpKH5hiihMKM9gl0h5kb1+9QVesP9u0qY9Thvwacy7Xr0On8KJKY/1sseUsM7awufIndrl9FA5H4/sxghgLiKoxzX2Cohkwzs=
Received: by 10.49.21.8 with SMTP id y8mr4685958nfi.1172706050904;
        Wed, 28 Feb 2007 15:40:50 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Wed, 28 Feb 2007 15:40:50 -0800 (PST)
In-Reply-To: <200702281301.58026.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41024>

On 3/1/07, Andy Parkins <andyparkins@gmail.com> wrote:
> > Or are you trying to control newline mangling on Windows/Mac clients?
> > I'm not even sure where that mangling happens. If that's the case, a
>
> It seems to be happening in the client.  In fact it's a given that it happens
> in the client as only the client knows what the local line ending rules are.

Ok - that's an interesting bit of info. I wasn't sure.

> > repo-wide toggle is useless, you really want the per-file-type rules
> > you mention.
>
> "Useless" is a strong word; especially as I'm finding it very useful :-).

I guess what I mean is that the common case on windows is going to be
for users who want their binary files un-corrupted, and their text
files newline-converted.

In fact, I think we should have it set to default to binary -- which
does the best job of preserving data. And override that based on file
extension (configurable) or  check the "head" of the file cheaply for
binary-ness before we update the file on the client side.

I agree with the idea of doing something smart with -kb flags, but
this is not a good move. For the common case among Windows TortoiseCVS
users, the switch proposed introduces the ability to switch between
one broken mode to another broken mode.

(And in terms of temporary workarounds, TortoiseCVS has a switch in
itself to disable newline conversion.)

cheers,


martin
