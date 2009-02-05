From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 06/11] Implement basic customizable label decorations
 with preferences
Date: Thu, 05 Feb 2009 22:44:23 +0100
Message-ID: <498B5DB7.7090905@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <498B4A66.9020108@gmail.com> <498B5374.1030305@gmail.com> <200902052236.01478.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVC2l-0003e7-Vm
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZBEVo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 16:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZBEVo3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:44:29 -0500
Received: from qb-out-0506.google.com ([72.14.204.233]:20953 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbZBEVo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:44:28 -0500
Received: by qb-out-0506.google.com with SMTP id q18so312032qba.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 13:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Jq3WT378yfTmGB2upeNYchT0PACGN5k/dcX9EVbnuP0=;
        b=wRBH2PFQSupt0yGerFwaWbcPQJr4QHFhmhjOrr16oC8octSNUTCXjLSuuGBy+jSib0
         FY+DGQVFM+78sJIXrvpIGHuxrThlQOIccTVcN8r41CnMuW1QPty7xZJbCW+w2McU7Fcj
         CL0UCuuMwK6FPoMW4fb+6JxsmhHM+tsS51hzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lZbEhtm/avdGULRTxP2klTg6mxEFjhaecbFZh/Mn4upaUFf27koJm+nWzhVJAs80w8
         OiW0f5rrJx3HtL5Bnua8KDTgAgETaJP02Qsd8PEsNwGADKFqRBnQKyjPiu82d0plfvJX
         FtgPzvKFAvyy8o4I8SrsMuUaKgqb7uwGhwyWs=
Received: by 10.103.11.5 with SMTP id o5mr405302mui.132.1233870266940;
        Thu, 05 Feb 2009 13:44:26 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id u9sm1877045muf.55.2009.02.05.13.44.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 13:44:26 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200902052236.01478.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108625>

Robin Rosenberg wrote:
> torsdag 05 februari 2009 22:00:36 skrev Tor Arne Vestb=F8:
>> Here are two alternatives. The first one (A) uses the same icons as
>> before, but adds red and green shading. The second one (B) uses the
>> green plus sign for added (which is used all over the place in Eclip=
se
>> to mean 'added'), and the gray x for removed (which is also used all
>> over the place in Eclipse for that same concept).
>>
>> http://img443.imageshack.us/img443/5138/egitmockupmm7.png
>>
>> I favor solution B, as it uses recognizable concepts from the existi=
ng
>> Eclipse UI, plus that having a red removed-icon conflicts too much w=
ith
>> the conflict-icon (pun intended). There's also a very similar red ic=
on
>> in JDT that indicates that something needs fixing (a red medic kit),
>> which is another reason to go with solution B.
>=20
> I go with B.

All right :)

> Btw, shouldn't staged, added and removed also count as outgoing, i.e.=
 ">" ?

Currently there's two variables, 'dirty', and 'staged'. The former
mappps to a diff between working directory and index, and has the
default symbol '>'. The latter mapps to a diff between index and
repository, with the default symbol '*'.

The default decoration for files does not have the 'staged' variable,
but you can add {staged} for a *, or override with {staged:>} for a >.

The idea was to get both states between wd and index and index and repo
in the decorators. We could add an option to treat both as one, ie only
care about wd vs repo?

I plan to implement the synchronize view too, in which case we could
share these two pieces of information between the Package Explorer (wd
vs index), and the Synchronize View (index vs repo), similar to how git
gui works.

Tor Arne
