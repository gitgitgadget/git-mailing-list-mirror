From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Wed, 12 Nov 2008 10:02:10 +0000
Message-ID: <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
	 <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com>
	 <20081112080103.GA25454@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0CZO-0004fQ-Ew
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYKLKCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 05:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbYKLKCP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:02:15 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:1861 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbYKLKCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 05:02:13 -0500
Received: by mu-out-0910.google.com with SMTP id g7so332639muf.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZoYxESgSONvw1oojMJIdlpE9iVFrgdALm9TQgppn/tE=;
        b=N7OMvcnarZ23aV/LKG59j9xMF6rRKBbonolqzAuaOr9nkgUQioyNA8FigK2BOJXc+R
         mifypTKJZVguxUfy4YkWQvc1nQ73DV4MVL6+ZxshWaSluikd//GEhrys3tz196Bv/1LC
         +OS1hLdPByVg2pRC9ktqPk3/IoDdejKstAW3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fiOPiLF3AgD/zfzFU5qxFRzx5HHKnXCScZLA4+nib8ryydK5Wh+Nfm7J3+GQrdRQTT
         i/foUvfLH40p4eTxMCyLvNLHBAVMNac8yq4fAcB2+7ykSNSGN8FRkyTeqRTcOlfT4hhb
         fLvghNdZxK2u41Y7Q+LpMyiSxhA6EYi3V5qq0=
Received: by 10.187.166.4 with SMTP id t4mr3122406fao.73.1226484130433;
        Wed, 12 Nov 2008 02:02:10 -0800 (PST)
Received: by 10.187.191.12 with HTTP; Wed, 12 Nov 2008 02:02:10 -0800 (PST)
In-Reply-To: <20081112080103.GA25454@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100733>

2008/11/12 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-11-11 17:59:02 +0000, Catalin Marinas wrote:
>> Could be related to this - if I run 'stg goto some-patch' and it
>> fails with a conflict, the HEAD points to the previous patch though
>> the stack has the conflicting patch as empty (which is normal) and
>> the conflicts in the index. Anything after that says HEAD and top
>> not equal and 'stg repair' is needed.
>
> Ah, yes, that could definitely be the same problem, since those two
> things end up calling the same functions to handle the conflict.

I think it's just a matter of updating HEAD on the "merge_conflict"
path but I'm still not fully confident in modifying the new lib
infrastructure.

> I'll build a test case for that as well.

We test the conflicts quite a lot in the "push" tests but this command
hasn't been converted to the new infrastructure yet.

--=20
Catalin
