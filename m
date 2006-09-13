From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 15:01:02 -0400
Message-ID: <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, dev@cvs2svn.tigris.org
X-From: dev-return-1615-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Wed Sep 13 21:01:53 2006
Return-path: <dev-return-1615-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNZyr-0006pa-Va
	for gcvscd-dev@gmane.org; Wed, 13 Sep 2006 21:01:06 +0200
Received: (qmail 18067 invoked by uid 5000); 13 Sep 2006 19:01:04 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 18057 invoked from network); 13 Sep 2006 19:01:03 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAMjwB0WLJkYCCQIKCQYd
X-IronPort-AV: i="4.09,160,1157353200"; 
   d="scan'208"; a="26732581:sNHT18314072"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T5XTZ6/UOyW8ecZgsDxLOtlPqIPdm0PncohxeMldfBFyeXpkPagWHZ3vQ5Q7OSPruRZytBpL2hABGzSdaK+M6Da23m6IoTPM7SLkjIHmCcJWwci7xTvHBdlHWb44+4V9vME2aY/oARnuQxEtaIcXGCQF8CcFW0iVGZRGg6X38xE=
To: "Markus Schiltknecht" <markus@bluegap.ch>, 
	"Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <45084400.1090906@bluegap.ch>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26933>

Let's copy the git list too and maybe we can come up with one importer
for everyone.

On 9/13/06, Markus Schiltknecht <markus@bluegap.ch> wrote:
> Hi,
>
> I've been trying to understand the cvsimport algorithm used by monotone
> and wanted to adjust that to be more like the one in cvs2svn.
>
> I've had some problems with cvs2svn itself and began to question the
> algorithm used there. It turned out that the cvs2svn people have
> discussed an improved algorithms and are about to write a cvs2svn 2.0.
> The main problem with the current algorithm is that it depends on the
> timestamp information stored in the CVS repository.
>
> Instead, it would be much better to just take the dependencies of the
> revisions into account. Considering the timestamp an irrelevant (for the
> import) attribute of the revision.
>
> Now, that can be used to convert from CVS to about anything else.
> Obviously we were discussing about subversion, but then there was git,
> too. And monotone.
>
> I'm beginning to question if one could come up with a generally useful
> cleaned-and-sane-CVS-changeset-dump-format, which could then be used by
> importers to all sort of VCSes. This would make monotone's cvsimport
> function dependent on cvs2svn (and therefore python). But the general
> try-to-get-something-usefull-from-an-insane-CVS-repository-algorithm
> would only have to be written once.
>
> On the other hand, I see that lots of the cvsimport functionality for
> monotone has already been written (rcs file parsing, stuffing files,
> file deltas and complete revisions into the monotone database, etc..).
> Changing it to a better algorithm does not seem to be _that_ much work
> anymore. Plus the hard part seems to be to come up with a good
> algorithm, not implementing it. And we could still exchange our
> experience with the general algorithm with the cvs2svn people.
>
> Plus, the guy who mentioned git pointed out that git needs quite a
> different dump-format than subversion to do an efficient conversion. I
> think coming up with a generally-usable dump format would not be that easy.
>
> So you see, I'm slightly favoring the second implementation approach
> with a C++ implementation inside monotone.
>
> Thoughts or comments?
> Sorry, I forgot to mention some pointers:
>
> Here is the thread where I've started the discussion about the cvs2svn
> algorithm:
> http://cvs2svn.tigris.org/servlets/ReadMsg?list=dev&msgNo=1599
>
> And this is a proposal for an algorithm to do cvs imports independant of
> the timestamp:
> http://cvs2svn.tigris.org/servlets/ReadMsg?list=dev&msgNo=1451
>
> Markus
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: dev-unsubscribe@cvs2svn.tigris.org
> For additional commands, e-mail: dev-help@cvs2svn.tigris.org
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
