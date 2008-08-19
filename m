From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 10:54:58 -0400
Message-ID: <32541b130808190754l43f053abnc4e3c5c064d6ade7@mail.gmail.com>
References: <48AA4263.8090606@gmail.com>
	 <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pat LeSmithe" <qed777@gmail.com>, git@vger.kernel.org
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVScw-00028w-5u
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbYHSOzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYHSOzB
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:55:01 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41533 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYHSOzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:55:00 -0400
Received: by gxk9 with SMTP id 9so5104245gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yK4kissfOI3lfBMKOhWKbRUtueLrJIXWLHKkjQYoHkM=;
        b=B8doiSOoIEi31MOCoayOEmIHkGf7Illbkiwp6pAnx/5ETWJ7Z86Q1ju1mAzPrK70OU
         Vr+xY+FZ0uit9uKHSA/KeoHTbPNZx8J54LJ+A8LRs82vfjpaB5AWP0K8ieEGrA5R2oSG
         2vGq11xDhA/AwzvdlVqtUT9/cumr3Kybcz6YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rHRavepBBq/hL1QoTdvPfV6jqX+IIaMpeKGqQAW6oAa421PfVoPgWXzijoToJBTs16
         mrbjJ0pRE6HgbqIi1sYx5gPmhOVa/4STa/Q9bHAVD8qXma36n6sk3fPOXBFWvC32/8n0
         e1Ydjmv2jl7HlWJDCZmLxIg/thPuJiMV5B9fQ=
Received: by 10.150.140.16 with SMTP id n16mr11986364ybd.142.1219157699112;
        Tue, 19 Aug 2008 07:54:59 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Tue, 19 Aug 2008 07:54:58 -0700 (PDT)
In-Reply-To: <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92871>

On Tue, Aug 19, 2008 at 10:32 AM, David Tweed <david.tweed@gmail.com> wrote:
> One problem with chronological backups is that they often don't
> compile/run so you can't bisect on them. One thing I have been trying
> to figure out is if there's an easy way to modify my build system so
> that it makes a commit approximately every 10 minutes but just after a
> successful compile. However, that looks to be a bit too complex and
> error prone for the moment.

You could just have a makefile rule or bash alias that does something
like "make && git commit -a -m temp".  Then remember to always run
that instead of 'make' when you're building.

Of course, committing on a side branch and not screwing with the index
would be much less intrusive.

Avery
