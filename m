From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 16:10:01 -0400
Message-ID: <005101d0adf0$964bca10$c2e35e30$@nexbridge.com>
References: <1435020656.28466.8.camel@twopensource.com>	 <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com> <1435089895.28466.65.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'git mailing list'" <git@vger.kernel.org>,
	"'ronnie sahlberg'" <ronniesahlberg@gmail.com>
To: "'David Turner'" <dturner@twopensource.com>,
	"'Stefan Beller'" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:10:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UWK-0005JS-9S
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbbFWUKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:10:08 -0400
Received: from elephants.elehost.com ([216.66.27.132]:43426 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbbFWUKG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:10:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t5NKA2gu086940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jun 2015 16:10:03 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <1435089895.28466.65.camel@twopensource.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ1O/YN/henzw5pG8BC73xzk1Dn5wJTjVJeARUmkxWcViLwgA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272492>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of David Turner
> Sent: June 23, 2015 4:05 PM
> To: Stefan Beller
> Cc: git mailing list; ronnie sahlberg
> Subject: Re: RFC/Pull Request: Refs db backend
> 
> On Tue, 2015-06-23 at 10:16 -0700, Stefan Beller wrote:
> > > The db backend code was added in the penultimate commit; the rest is
> > > just code rearrangement and minor changes to make alternate backends
> > > possible.  There ended up being a fair amount of this rearrangement,
> > > but the end result is that almost the entire git test suite runs
> > > under the db backend without error (see below for
> > details).
> >
> > Looking at the end result in refs-be-db.c it feels like there are more
> > functions in the refs_be_db struct, did this originate from other
> > design choices? IIRC Ronnie wanted to have as least functions in there
> > as possible, and share as much of the code between the databases, such
> > that the glue between the db and the refs code is minimal.
> 
> I didn't actually spend that much time reading Ronnie's backend code.
> My code aims to be extremely thoroughly compatible.  I spent a ton of time
> making sure that the git test suite passed.  I don't know if an alternate
> approach would have been as compatible.
> 
> The requirement for reflog storage did complicate things a bit.
> 
> I also didn't see a strong need to abstract the database, since LMDB is common,
> widely compatible, and tiny.

Just to beg a request: LMDB is not available on some MPP architectures to which git has been ported. If it comes up, I beg you not to add this as a dependency to base git components.

Thanks,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
