From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 08 Feb 2008 14:58:09 -0600
Message-ID: <47ACC261.6060404@nrlssc.navy.mil>
References: <20080208174654.2e9e679c@pc09.procura.nl>	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com> <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNaJy-0004Va-IG
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbYBHU7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYBHU7G
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:59:06 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38511 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbYBHU7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:59:05 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m18Kw9Xe013071;
	Fri, 8 Feb 2008 14:58:09 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Feb 2008 14:58:09 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 08 Feb 2008 20:58:09.0519 (UTC) FILETIME=[4F6BB7F0:01C86A95]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--7.131400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : 
	150567-700075-139010-701848-705388-704852-188198-700971-148039-148051
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73144>

Junio C Hamano wrote:

> And have Makefile set FOPEN_OPENS_DIRECTORIES on appropriate
> platforms.

Which ones _don't_ open directories?

Shouldn't fopen("path_to_some_directory", "r") work?

-brandon

#include <stdio.h>

int main(int argc, char* argv[])
{
    if (!fopen(argv[1], "r")) {
        perror("File open failed");
        return 1;
    }

    puts("File open succeeded.");

    return 0;
}
