From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Tracking empty directories
Date: Tue, 1 Feb 2011 20:15:09 +0200
Message-ID: <20110201181509.GA2370@LK-Perkele-VI.localdomain>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
 <20110201172835.GA3771@burratino>
 <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKlK-00042A-PK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab1BASPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 13:15:30 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:55669 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1BASP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:15:29 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 037158C97D;
	Tue,  1 Feb 2011 20:15:28 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05B57F3838; Tue, 01 Feb 2011 20:15:27 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B92DFE51A3;
	Tue,  1 Feb 2011 20:15:21 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165838>

On Wed, Feb 02, 2011 at 12:54:35AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 2, 2011 at 12:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> Could it be done with an index extension? Interesting.
> 
> > Certainly one ought to register an extension name or bump the version
> > number to avoid confusing gits that don't know about the feature.
> 
> Index extension with lowercase name are "necessary for correct
> operation". Older git will abort on unknown required extensions. If
> you add to the main part of the index, better bump version number.

Worse problem than the index: Tree entries. Those are actually transferable
and IIRC older (current?) git versions don't handle empty subdirectories
(pointing entry of type directory to empty tree hash) all too well...

Worse yet, there isn't easy way to break the tree parser to avoid current
git versions from screwing things up (IIRC, when I tested, invalid octal
numbers finally broke it, invalid file types didn't do the trick)...

-Ilari
