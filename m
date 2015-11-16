From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Mon, 16 Nov 2015 18:56:11 -0500
Message-ID: <CAPig+cR2t9w6x4YX6Fuc6sk6VMpMU=gfF4GaTz_3a47Px6mwPg@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
	<1447717227.23262.10.camel@intel.com>
	<CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTdA-0005wZ-IO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbbKPX4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:56:12 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33676 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbKPX4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:56:12 -0500
Received: by vkbs1 with SMTP id s1so197440vkb.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/ldUUdNv5LM2M+LC9mEdyAGJ5RCL9mLcf2Vf3lUdhtQ=;
        b=EWhpT4gzROy9ikHqWALA0D2KE/TBD8rzETdIGgZaMEzaOildl2dJSTBjjw6NP+Ep4W
         kF6b2nuRFIkmTrmQiJmHPAfz4Kieg+wQfUDoImOCAMDQxPdLhcxFUnPbl1WzqpKnmrds
         mFCVDkvjHf41JRlYyo5rOAdW/GTdAm1NonVFnToOOX5vHb3IRdVKjj/fJONtTtqWHNC+
         MGlxilr8dlCMGv30tLqDnmFoVkBw91+51RbsUYc+hVtbz/bib/4YglUIKJvr2hFLWvld
         7SxvMtLwMQG6PfBazSJw07aiXBlTCbHcJeRNsgXW81ocaqXHRbJc9Hd/kbBCX3KJguwu
         3iWQ==
X-Received: by 10.31.159.133 with SMTP id i127mr656528vke.37.1447718171548;
 Mon, 16 Nov 2015 15:56:11 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 15:56:11 -0800 (PST)
In-Reply-To: <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
X-Google-Sender-Auth: MGFMbH8mjz19rFJaHN-dVUgwadU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281369>

On Mon, Nov 16, 2015 at 6:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Also, shouldn't --list-aliases (or --dump-aliases) be mutually
> exclusive with many of the other options? New tests would check such
> exclusivity as well.

In fact, while I agree with Szeder that it makes sense to re-use
send-email's aliases parsing functionality (and was going to suggest
the same, but he beat me to it), this new option is awfully orthogonal
to the overall purpose of send-email, thus, doesn't really fit in well
and almost cries out for a command of its own which would be used by
send-email and bash completion (though I'm not convinced that it's
worth going that route for this one minor use-case).
