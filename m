X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: David Tweed <tweed314@yahoo.co.uk>
Subject: Average size of git bookkeeping data (related to Using git as a general backup mechanism)
Date: Wed, 13 Dec 2006 19:31:49 +0000 (GMT)
Message-ID: <20061213193149.43284.qmail@web86909.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
NNTP-Posting-Date: Wed, 13 Dec 2006 19:38:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:38:30 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iYuDBgMOhsxC2vvHhsg0wIbXzy7Cr4e+xxCoKO7VEETC0GO6UgP+j50Mww4oAaH1dUGWteMioTRFG6T4HDZ4281AGrR8t4jSfFrzYqd7l+goAatNcOcA4zkws1o8bTQ52suLeC+u7gH9fYYXukWoyfaVY1FLhWM15zRxYd05sak=  ;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34229>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuZw2-0008Mt-MQ for gcvg-git@gmane.org; Wed, 13 Dec
 2006 20:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965092AbWLMTib (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 14:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWLMTib
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 14:38:31 -0500
Received: from web86909.mail.ukl.yahoo.com ([217.12.13.61]:46817 "HELO
 web86909.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S965092AbWLMTia convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 14:38:30 -0500
Received: (qmail 43286 invoked by uid 60001); 13 Dec 2006 19:31:49 -0000
Received: from [134.225.1.161] by web86909.mail.ukl.yahoo.com via HTTP; Wed,
 13 Dec 2006 19:31:49 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,
This is in connection with the "Using git as a general backup mechanism" thread,
but on a different slant more along automatic versioning a subset of the files on the disc (to avoid
sucking in things like core files and particularly huge multimedia files). In this case I don't
want to discard old "backups" but just grow the chronological database. (Think a more selective version of
Plan 9's venti filesystem.)

How big is the "metadata" or "bookeeping data" in git related to a commit? (Eg, "around x bytes per changed file"
or "around x bytes per file being tracked (whether changed in the commit or not)" )

[I'm trying to get a feel for, if I switched to git, how much overhead would come from having a cron job automatically doing
a snapshot every hour (if anything has changed), plus manual snapshots at points where I want to feel "safeguarded".
I'm currently using my own simple, hacked together system for combined versioning/backups that does
this. Using naive tools that don't account for wastes space due to disk block size effects the data being
tracked is currently just under 9 months of acitvity on  2016 filenames with
17457599 bytes of data (ie, compressed version of their contents at various times) and 7838546 bytes
is "metadata", ie, 30 percent of the stored data is metadata. This is in a format using 6 bytes to associate a single blob of
contents to a filename (whether changed since last snapshot or not).]

Many thanks for any insight,

cheers, dave tweed



