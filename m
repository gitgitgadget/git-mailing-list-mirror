From: demerphq <demerphq@gmail.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 31 Jan 2012 11:11:55 +0100
Message-ID: <CANgJU+UxB-qAJOaqKKnMkTx7fW4cyqHrGy7myhCzizBFGtnMZg@mail.gmail.com>
References: <4F24E287.3040302@alum.mit.edu>
	<7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
	<4F263AEE.4080409@alum.mit.edu>
	<7v39axc9gp.fsf@alter.siamese.dyndns.org>
	<4F27ACED.2050709@alum.mit.edu>
	<4F27BBED.9080902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 11:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsAh0-0002jO-57
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 11:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab2AaKL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 05:11:57 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab2AaKL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 05:11:56 -0500
Received: by ghrr11 with SMTP id r11so2255765ghr.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=U/MbBF5gdsD1BGrf6uuVh6voI45425K0zs82oxMcctw=;
        b=SCedFpVgDDAxD+FznqcPWdQ5a6t0nWvz8ckEV3eQGwjUp1LTGjYQ/upnuAJytN9KVb
         n66pF6EVWjPefdBypo2CjBZKxB+APIKsTxAiOdgc7pi4sh/eMs0DyWfT2jYgxZ6ndC/g
         XbB0rqSEKZ/oZlO1Ao9ucx5InxtyCo7/PKjYE=
Received: by 10.236.191.5 with SMTP id f5mr32844479yhn.122.1328004715985; Tue,
 31 Jan 2012 02:11:55 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Tue, 31 Jan 2012 02:11:55 -0800 (PST)
In-Reply-To: <4F27BBED.9080902@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189449>

On 31 January 2012 11:01, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 1/31/2012 9:57, schrieb Michael Haggerty:
>> No, the idea is to avoid special casing by making 0{40} into a real =
(but
>> empty) revision.
>
> But then why not just have git init perform the equivalent of
>
> =A0c=3D$(echo "Start" | git commit-tree $empty_tree_sha1) &&
> =A0git update-ref refs/heads/master $c
>
> People who dislike an empty initial commit can always use "git commit
> --amend" for the first "real" commit.

Because it would then violate a system invariant that all commits are
descendants of the root commit.

You can model a git commit graph as a pathway through multidimensional
space of all possible commit trees. From that perspective it makes
sense that every pathway starts at the origin point of the
multidimensional space, which is conceptually the same as the proposed
root commit.

Anyway, I am not saying it should change, just that from some point of
views it makes a lot of sense.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
