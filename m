From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 23:18:36 +0200
Message-ID: <20080702211836.GF16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com> <20080702181021.GD16235@cuci.nl> <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9jx-0005hG-BZ
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610AbYGBVSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758448AbYGBVSi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:18:38 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:35400 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286AbYGBVSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:18:37 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4ED2A5465; Wed,  2 Jul 2008 23:18:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87192>

Dmitry Potapov wrote:
>On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>> In that case, I will stick to extending git fsck to check grafts more
>> rigorously and fix git clone to *refrain* from looking at grafts.

>Linus suggested that "git-fsck and repacking should just consider
>it[grafts] to be an  _additional_ source of parenthood rather than
>a _replacement_ source."

>http://article.gmane.org/gmane.comp.version-control.git/84686

Yes, I know that's what he suggested, the way it should be implemented
IMO though is by checking once without and once with regard to grafts.
And still it should be such that git clone disregards grafts completely.
I'll fix both, eventually, since I need this functionality to verify
correctness for the projects I'm working on at the moment.

As for repack, it should probably ignore grafts, except for reference.
I.e. repack/gc should consider all mentioned SHA1s in the grafts file
to be referenced and undeletable.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
