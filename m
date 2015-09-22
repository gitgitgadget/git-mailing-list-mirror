From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 13:42:26 -0700
Message-ID: <xmqq1tdq2nkd.fsf@gitster.mtv.corp.google.com>
References: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
	<20150922214037.b6b48059f051fcd4060a5a85@domain007.com>
	<CA+5PVA6YWJizRjseeJ4EpRya0Mpyrv3DoNsB3=Gi=dOiAoDfHg@mail.gmail.com>
	<xmqqpp1a2pql.fsf@gitster.mtv.corp.google.com>
	<CA+5PVA6zUXGs2R-MOoj5sBxwUqM7HP=tx-0WZJzPf71MsjH9MA@mail.gmail.com>
	<20150922204000.GC3318@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josh Boyer <jwboyer@gmail.com>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUOW-0000tE-De
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934609AbbIVUm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:42:28 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34837 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934570AbbIVUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:42:27 -0400
Received: by pacfv12 with SMTP id fv12so19214915pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6N6tt3yl2xyKbm5Zbrf0dE4hUIdfZyhJa1hNrphJvOc=;
        b=fRXP4hQrXCWxeaUasQ7uDBJXRnGYXGzgE8sfT+GKeVeux2Pz0YMuaIeWcNMYJ/qC+r
         U+E7Q1QdrGTBH8aLlgYoK/zhZvwRiMYjq08e+vCRVcwszuGpVJDuwYcwCFw2x7Jv6sB1
         8qgMlYLs2BvpfqyyXKhyr4zA6MYDYWxkMgadEFpwLa5FKzBR01SA1FL8f3/MggfTnKJI
         bSpw15YJELQhb/HAKquQPLHCEv6MrtnVEnzbJZVEzdEsgrc8jSR5LzBqkXFCoC1GVtYn
         VfCtLp6+ulapxgpEvBnZ/X26HUU29wF89kKfIrmfMV0W2ieeHyUEOZyqNep8Gd3Asa9Y
         wnoA==
X-Received: by 10.68.96.197 with SMTP id du5mr32816346pbb.32.1442954547461;
        Tue, 22 Sep 2015 13:42:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id l16sm457000pbq.22.2015.09.22.13.42.26
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 13:42:26 -0700 (PDT)
In-Reply-To: <20150922204000.GC3318@thunk.org> (Theodore Ts'o's message of
	"Tue, 22 Sep 2015 16:40:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278434>

Theodore Ts'o <tytso@mit.edu> writes:

> On Tue, Sep 22, 2015 at 04:11:23PM -0400, Josh Boyer wrote:
>> Oh, context would help, yes.  In the case of the tree I'm parsing, I
>> know for a fact that the commit history is entirely linear and will
>> (should) always remain so.  E.g.
>> 
>> A - B - C - D - E - F ... {N}
>> 
>> So yes, finding e.g. the second commit after the root is complicated
>> for something resembling anything like a typical git repo, but this
>> isn't like that.  In other words, I can cheat.  Or at least I'm pretty
>> sure I can cheat :).
>
> I'd suggest making your script makes sure "git rev-list --merges A..N"
> doesn't output any commits, so you know for sure that the commit
> history is linear.  That way you'll be certain that you can cheat.  :-)

There are histories with multiple roots without any merges, in which
case you cannot ;-)
