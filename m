From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to ensure a word has been removed from repository?
Date: Wed, 4 Nov 2009 09:05:55 +0530
Message-ID: <2e24e5b90911031935m2a0b9f70xd3d7975eea334d9e@mail.gmail.com>
References: <6fb3af8e0911031812j54a9b698xca9f5301ac07442a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Patrick Higgins <patrick.allen.higgins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5WfJ-0005bS-M9
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZKDDfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbZKDDfv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:35:51 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38813 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbZKDDfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:35:51 -0500
Received: by iwn10 with SMTP id 10so4674488iwn.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 19:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BnzrlND1OJOusXXdtV+FkuC3rPvvKPTWG0z4DxEuP40=;
        b=I+qhCfuSxQMoc+OmAdE1P91Wl5uRgiJlQZ+BrbFRqP5rH4XQi55+viRyzbZh6pOfOf
         p9Wqh/Xm9DQ/B0ABwm3ff+Sr3URK+Qc9I2PVa47SaULMtTo1DaFxteBU44de4W7/sOLg
         bA+n7PXQf6NY3KajiovTvFogS9ZhoLC93ghow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=En9HrLNbVB5UflzboRsOUgh+ovKm3jnOwUlib2YHO3YQtkwzG4EBC8M7oh7rYHy7I2
         7+UfBqPsBnFA7e6u9GGYDk7lG7IvmJm/z6wgRFEJ0t0af0K4JJh9OMjntcEN4ZnnKGWz
         ZaPhLXhsmQTgpKIL+5TAfO4bf1YZQ9WPWVkNI=
Received: by 10.231.42.150 with SMTP id s22mr2771456ibe.22.1257305756000; Tue, 
	03 Nov 2009 19:35:56 -0800 (PST)
In-Reply-To: <6fb3af8e0911031812j54a9b698xca9f5301ac07442a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132031>

On Wed, Nov 4, 2009 at 7:42 AM, Patrick Higgins
<patrick.allen.higgins@gmail.com> wrote:

> Given that much of the repository is stored in compressed packs, I
> can't just use grep to look for the words. To get around this, I've
> unpacked the objects, use a Perl script (filtinf example script) to
> decompress them and then use grep (this has proven to be quite slow).

> Is that going to find every possible occurrence if all the relevant
> files are plain text?

> Is there an easier way to search the repository? The way I'm doing it
> has required some awfully deep knowledge to expire and prune
> everything. I feel like I must be missing something.

Instead of expire and prune, I'd clone the repo to some other
location, and search in that clone.  You'd still need the commands
that Nicolas gave in his reply but you wouldn't get any false
positivies from missing some reflog or something kept a ref alive.
