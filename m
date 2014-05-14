From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Wed, 14 May 2014 21:32:06 +0000
Message-ID: <20140514213206.GA12228@debian>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
 <xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
 <20140513230201.GA32562@debian>
 <xmqqy4y5l1c7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgmd-00010j-CO
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbaENVcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:32:11 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:61645 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbaENVcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:32:10 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so156620wes.23
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=65GSD0A6koLIzgDwyd80g3XwCQiRA2YWAsbQdkJxbl8=;
        b=VKGHztrynkn2pIcmnASvl4auYW616dq+RPRrMMMqQo7+BiI2Hy/MUVm5VEbaX15zgV
         1TMI8ypt6wAWkcs/GHXYkHzrk7C7R9nmtZAj3ZUpy85sgY9MEN9jHDCHBqPvxPl9oyTw
         3KtYO+vxGN5GsQcgyloUc5tdauNRg5PhMNDdJL1eJBANAWIaulx5soWRPQK99GAqTTBF
         socjF/eAzMMq2gRymHDnqo22S4/b5uwL1j12q8uHKCINR43xh1l5D4OTOdk3o4eFdOIK
         B38WBcI7iPP0hmI8NqTwXbGAkuFqFhc3MmZQX9+prvaoh6HD9ByGfJECUZs9YhAJiJON
         pjNA==
X-Received: by 10.180.24.68 with SMTP id s4mr5474307wif.12.1400103128590;
        Wed, 14 May 2014 14:32:08 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id b16sm4041134wjx.45.2014.05.14.14.32.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 14:32:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqy4y5l1c7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248998>

On Tue, May 13, 2014 at 04:12:56PM -0700, Junio C Hamano wrote:
> James Denholm <nod.helm@gmail.com> writes:
> 
> > I'm not sure that can actually happen - peel_committish is essentially
> > implemented as `rev-parse $arg^0` (though with a bit of bling, of
> > course), and to my understanding FETCH_HEAD will always parse to a
> > committish - I could have missed something, of course.
> 
>  $ git fetch git://repo.or.cz/alt-git junio-gpg-pub
>  $ git rev-parse FETCH_HEAD^0

That would be a problem... Sadly I doubt I'll have time to develop a
solution into subtree's overall design before the end of June. As that
eventual change would probably involve altering the inclusions of this
fix, and that users have a workaround in adding either squashed commits
or referencing lightweight tags, would you rather drop the patch and
wait for that?

---
Regards,
James Denholm.
