From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Wed, 13 Mar 2013 20:44:36 +0000
Message-ID: <A54CE3E330039942B33B670D971F85740399654B@TK5EX14MBXC252.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 21:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFsYd-00006o-1p
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 21:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab3CMUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 16:45:28 -0400
Received: from mail-bn1lp0153.outbound.protection.outlook.com ([207.46.163.153]:14943
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933178Ab3CMUp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 16:45:27 -0400
Received: from BY2FFO11FD010.protection.gbl (10.1.15.200) by
 BY2FFO11HUB028.protection.gbl (10.1.14.139) with Microsoft SMTP Server (TLS)
 id 15.0.620.12; Wed, 13 Mar 2013 20:45:24 +0000
Received: from TK5EX14HUBC107.redmond.corp.microsoft.com (131.107.125.37) by
 BY2FFO11FD010.mail.protection.outlook.com (10.1.14.74) with Microsoft SMTP
 Server (TLS) id 15.0.620.12 via Frontend Transport; Wed, 13 Mar 2013 20:45:24
 +0000
Received: from TK5EX14MBXC252.redmond.corp.microsoft.com ([169.254.1.2]) by
 TK5EX14HUBC107.redmond.corp.microsoft.com ([157.54.80.67]) with mapi id
 14.02.0318.003; Wed, 13 Mar 2013 20:44:37 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAAJx4fA=
In-Reply-To: <7va9q72n1u.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.74]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(51704002)(189002)(24454001)(199002)(47446002)(74662001)(47976001)(54356001)(69226001)(23726001)(79102001)(54316002)(49866001)(65816001)(33656001)(46102001)(76482001)(50986001)(46406002)(51856001)(53806001)(59766001)(16406001)(47736001)(44976002)(77982001)(47776003)(74502001)(31966008)(56776001)(55846006)(66066001)(4396001)(80022001)(20776003)(50466001)(63696002)(56816002);DIR:OUT;SFP:;SCL:1;SRVR:BY2FFO11HUB028;H:TK5EX14HUBC107.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 0784C803FD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218092>

Junio C Hamano [mailto:gitster@pobox.com] wrote:
> I do not offhand see anything particularly stupid; a new optional index extension
> section CACHE_EXT_RENAME_CONFLICT might be a good addition.
> 
> Is "one side moves A to B while the other side moves it to C" the only case, or is
> it just an example?  Off the top of my head, "one side moves A to x while the
> other side moves B to x/y" would also be something we would want to know.  I
> am sure there are other cases that need to be considered.

Yes, that was just an example.  Certainly I was intending that all conflicts
that arose from renames would end up here since one can't really reason
why the merge tool created a conflict by looking at the index alone - even
knowing the merge tool's similarity algorithms, this would be awfully
expensive to piece back together, even if the index did contain non-zero
stage entries for all the items that were involved in the conflicts.

That said, my rather naive initial thought was that we could repeat *all*
conflicts in this area.  This would give tools that knew how to understand
this the ability to go to a single place for conflict data, rather than
producing some merge of high-stage entries that comprise non-rename
conflicts and data from the rename conflict area for rename conflicts.

Thanks-
-ed
