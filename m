From: "Patwardhan, Rajesh" <rajesh.patwardhan@etrade.com>
Subject: RE: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 12:42:05 -0400
Message-ID: <0BB549C6E74E24409FB20B3B1D1B664402946577@ATL1EX11.corp.etradegrp.com>
References: <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Martin Langhoff" <martin.langhoff@gmail.com>,
        "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>,
        <git@vger.kernel.org>, <users@cvs2svn.tigris.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: users-return-1614-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Aug 03 18:42:15 2007
Return-path: <users-return-1614-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IH0EA-0001lI-Cz
	for gcvscu-users@gmane.org; Fri, 03 Aug 2007 18:42:14 +0200
Received: (qmail 11983 invoked by uid 5000); 3 Aug 2007 16:42:12 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 11969 invoked from network); 3 Aug 2007 16:42:12 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAPL3skYMmeA3n2dsb2JhbACOEAICBwQGBwgY
X-IronPort-AV: i="4.19,217,1183359600"; 
   d="scan'208"; a="63533643:sNHT27036590"
X-IRONPORT: SCANNED
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <9e4733910708030841r31175efg4ea4ea41e852ab2@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: cvs2svn conversion directly to git ready for experimentation
Thread-Index: AcfV5LRkvxUA8eGgQRK+kNgDOH9ibQACBCRw
X-OriginalArrivalTime: 03 Aug 2007 16:42:06.0153 (UTC) FILETIME=[3A115B90:01C7D5ED]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54733>

Thank you very much for the email.=20
Yes if the time for conversion can be brought down to 1/2 hour then it
would be really great.=20
We could do a automated cvs2svn everyday for testing and that way
maximum lag between cvs and test svn repo would be 1 day.=20
Please do let me know when available.
Regards,
Rajesh=20

-----Original Message-----
From: Jon Smirl [mailto:jonsmirl@gmail.com]=20
Sent: Friday, August 03, 2007 8:41 AM
To: Patwardhan, Rajesh
Cc: Michael Haggerty; Martin Langhoff; Guilhem Bonnefille;
git@vger.kernel.org; users@cvs2svn.tigris.org
Subject: Re: Re: cvs2svn conversion directly to git ready for
experimentation

On 8/3/07, Patwardhan, Rajesh <rajesh.patwardhan@etrade.com> wrote:
>
> Hello Michael,
> I will explain a scenario (we are passing thru this right now)
> 1) you have 10 years worth of cvs data.
> 2) We want to move to svn.
> 3) The repository move should be in such a way that the development=20
> does not get hampered for any 1 work day.
> 4) We have atleast 4 major modules in cvs which takes about 30 - 40=20
> hours each for conversion currently.

There are known ways (that haven't been implemented) to get the 40 hr
number down to 1/2 hour. Would that be a better approach than doing
incremental imports?

> 5) With increamental conversions we can do a few things ...
>         A) Keep the downtime for hard cutoff minimal
>         B) try out the svn move for other auxillary tools that are=20
> needed by the SCM process.
>         C) Do some meaningful testing and validation with simulated=20
> live moves of changes from cvs to svn before the actual move on a day=20
> to day basis.
>
> Hopefuly this would substantiate the request \ need for increamental=20
> moves. Or if someone out there has a better suggestion for such=20
> scenario's please point me in the right direction.
>
> Regards,
> Rajesh
>
> -----Original Message-----
> From: Michael Haggerty [mailto:mhagger@alum.mit.edu]
> Sent: Friday, August 03, 2007 1:36 AM
> To: Martin Langhoff
> Cc: Guilhem Bonnefille; git@vger.kernel.org; users@cvs2svn.tigris.org
> Subject: Re: cvs2svn conversion directly to git ready for=20
> experimentation
>
> Martin Langhoff wrote:
> > Is there any way we can run tweak cvs2svn to run incrementals, even=20
> > if
>
> > not as fast as cvsps/git-cvsimport? The "do it remotely" part can be

> > worked around in most cases.
>
> I don't see any fundamental reason why not, but I think it would be a=20
> significant amount of work.  There are two main issues:
>
> 1. With CVS, it is possible to change things retroactively, such as=20
> changing which version of a file is included in a tag, or adding a new

> file to a tag, or changing whether a file is text vs. binary.  And=20
> many people copy and/or rename files within the CVS repository itself=20
> (to get around CVS's inability to rename a file).  This makes it look=20
> like the file has *always* existed under the new name and *never*=20
> existed under the old name.  An incremental conversion tool would have

> to look carefully for such changes and either handle them properly or=20
> complain loudly and abort.
>
> 2. cvs2svn uses a lot of repository-wide information to make decisions

> about how to group CVSItems into changesets, and a lot of these=20
> decisions are based on heuristics.  Incremental conversion would=20
> require that the decisions made in one cvs2svn run are recorded and=20
> treated as unalterable in subsequent runs.
>
> This hasn't been a priority in the Subversion world, because, frankly,

> what reason would a person have to stick with CVS instead of switching

> to Subversion, given that (1) they are intentionally so similar in=20
> workflow, an (2) there is no significant competition from other=20
> centralized SCMs?  But of course until the distributed SCM playing=20
> field has been thinned out a bit, people will probably be reluctant to

> commit to one or the other.
>
> I don't expect to have time to implement incremental conversions in=20
> cvs2svn in the near future.  (I'd much rather work on output back ends

> to other distributed SCMs.)  But if any volunteers step forward (hint,
> hint) I would be happy to help them get started and answer their=20
> questions.  I think that cvs2svn is quite hackable now, so the=20
> learning curve is hopefully much less frightening than when I started=20
> on the project :-)
>
> Michael
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: users-unsubscribe@cvs2svn.tigris.org
> For additional commands, e-mail: users-help@cvs2svn.tigris.org
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in the=20
> body of a message to majordomo@vger.kernel.org More majordomo info at

> http://vger.kernel.org/majordomo-info.html
>


--
Jon Smirl
jonsmirl@gmail.com
