From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix to push --progress. The --progress flag was not
 being passed into tranport.c from send-pack.h, making the --progress flag
 unusable
Date: Tue, 12 Oct 2010 17:44:57 -0500
Message-ID: <20101012224456.GC15587@burratino>
References: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chase Brammer <cbrammer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ndw-0004WZ-P6
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0JLWsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:48:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58409 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0JLWsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:48:17 -0400
Received: by qwa26 with SMTP id 26so683654qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TPpo5BQBBT0sCJk24UsjajrHeVOfIiQXev129/1FNXs=;
        b=quT5jVeBV6vL9nB/y/R3vTHc71HJgL8AvXYLTr0laK7mOzFsjCl837IidqesEmSwPg
         qV9EWnfNPp7rN868rNQT/5VeTxzw3KVJLUpfOIQlGoUpd+5oJLZpmuiP+MQYezEUBAJ5
         7DzrN01kJs4VIXNjxx22vzjAppMMWLKJzkR90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rP+t8WjqsU51oxlCTwIvsf6bdGU4pSTLdVqSR/BBdAdlpqezmlNOBGJnFQia2bJVV5
         sXYk0kKTnkJ4DtVJVcwASV3lcWr0kId5ppWBEDWJfIzs1BLhUi0kOqg0aUgBMY78kRkc
         cJdrC14YW8xPx1M10a4xuW1CFwqZCIhyH9h8Q=
Received: by 10.229.230.4 with SMTP id jk4mr6834490qcb.174.1286923696682;
        Tue, 12 Oct 2010 15:48:16 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm3937198qco.6.2010.10.12.15.48.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:48:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin9_kofdy49WF4V_JoovVR+G8DN7vn-cz3p84fz@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158888>

Chase Brammer wrote:

> The result of this is external tools and tools writing standard error
> to a file from bash would not be able to receive progress information
> during a push.  Similar functionality is seen in fetch, which still
> works.

A bit of protocol: since the patch is by Jeff, this should have

	From: Jeff King <peff@peff.net>

at the beginning of the log message.  See Documentation/SubmittingPatches
for details.

> Helped-by: Jonathan Nieder <jrnieder@gmail.com>

I didn't help. :)

>  builtin/send-pack.c |    3 +++
>  send-pack.h         |    1 +
>  transport.c         |    1 +
>  3 files changed, 5 insertions(+), 0 deletions(-)

It's not necessary by any means, but it would be nice to add a test
for this to t/ so no one breaks the new functionality in the future.

Thanks.
