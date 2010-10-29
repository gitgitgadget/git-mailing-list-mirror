From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 19:54:10 +0100
Message-ID: <AANLkTikc+pBe31j9tA88HwGz2kBouW_0S9oU6PtSQEzj@mail.gmail.com>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
	<7vbp6c7ski.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 20:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBu5h-0003dP-04
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 20:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050Ab0J2SyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 14:54:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45360 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab0J2SyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 14:54:11 -0400
Received: by yxk8 with SMTP id 8so1854304yxk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MpGam3Y2wQ6iexCrD5rFZ/1iC+putOi2o673nJ8JdYQ=;
        b=jWNbuqA/97DhBuE1Elb3ki35bg65RBWGjJr/xUpOHk7TPKUDHqilVz2QQTfsOpJt0H
         ppTtg0eACn1f1efYhZEKfey8oabBNgZ6MXTQc0H+CanI5wzNS8p6inmNkNMsSmbbT6Tk
         8ANsQcfhndOaTe0EH5yA3IZM+OvNBxrtX8kos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NV1fxIF0zM5PD0ww1EoWiD6qsfDKASeD81wLODblRusawiPoXrcqZ28ii20xaCmGA3
         JjmZO+/FNfHrbLP5CDSwGCvqttVc6Rm+wITCNAjCuVq+DVARNBQsou/5lJVI2kqEuszn
         /ZrtS4dZLAGomN4WGRRSw5UlGHkjCvv9QtC3E=
Received: by 10.42.203.68 with SMTP id fh4mr9831005icb.287.1288378450270; Fri,
 29 Oct 2010 11:54:10 -0700 (PDT)
Received: by 10.220.201.13 with HTTP; Fri, 29 Oct 2010 11:54:10 -0700 (PDT)
In-Reply-To: <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160355>

On Fri, Oct 29, 2010 at 7:38 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I do not think there is any bug. =A0You were being bitten by folks wh=
o tried
> to be helpful for newbies by introducing a(n arguably confusing) spec=
ial
> case; I can see why this is confusing, though.

Thanks.

We just switched to Git, and our developers got used to being able to
just `git checkout branch` to create a local remote-tracking one for
that remote branch.

Then we were bitten by a branch `foo` when path `./foo` existed.

I think the syntactic sugar needs to either be removed, or
(preferably) be made consistent.

The current behavior is that if I try to checkout a branch that
doesn't exist, but does exist on the remote, git creates a local
remote tracking branch for the one I tried to check out.

It makes no sense IMHO for the disambiguating syntax to break that
behavior, especially since in some cases, the disambiguating syntax is
necessary.

Thanks, D
