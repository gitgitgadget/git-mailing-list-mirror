From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 07:02:35 +0200
Message-ID: <4508E26B.5000106@alum.mit.edu>
References: <45084400.1090906@bluegap.ch>	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>	<4508724D.2050701@bluegap.ch>	<46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>	<4508D7DA.8000302@alum.mit.edu> <9e4733910609132134j63857912keed6a42682f69d66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
        Markus Schiltknecht <markus@bluegap.ch>,
        Git Mailing List <git@vger.kernel.org>, monotone-devel@nongnu.org,
        dev@cvs2svn.tigris.org
X-From: dev-return-1642-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 07:02:45 2006
Return-path: <dev-return-1642-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNjN5-0001b0-G2
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 07:02:44 +0200
Received: (qmail 27685 invoked by uid 5000); 14 Sep 2006 05:02:41 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 27675 invoked from network); 14 Sep 2006 05:02:41 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAK5/CEWLbAIJDg
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26770415:sNHT17027878"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060728 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609132134j63857912keed6a42682f69d66@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26982>

Jon Smirl wrote:
> On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> But aside from this point, I think an intrinsic part of implementing
>> incremental conversion is "convert the subsequent changes to the CVS
>> repository *subject to the constraints* imposed by decisions made in
>> earlier conversion runs.  And the real trick is that things can be done
>> in CVS (e.g., line-end changes, manual copying of files in the repo)
>> that (a) are unversioned and (b) have retroactive effects that go
>> arbitrarily far back in time.  This is the reason that I am pessimistic
>> that incremental conversion will ever work robustly.
> 
> We don't need really robust incremental conversion. It just needs to
> work most of the time. Incremental conversion is usually used to track
> the main CVS repo with the new tool while people decide if they like
> the new tool. Commits will still flow to the CVS repo and get
> incrementally copied to the new tool so that it tracks CVS in close to
> real time.

I hadn't thought of the idea of using incremental conversion as an
advertising method for switching SCM systems :-)  But if changes flow
back to CVS, doesn't this have to be pretty robust?

In our trial period, we simply did a single conversion to SVN and let
people play with this test repository.  When we decided to switch over
we did another full conversion and simply discarded the changes that had
been made in the test SVN repository.

The use cases that I had considered were:

1. For conversions that take days, one could do a full commit while
leaving CVS online, then take CVS offline and do only an incremental
conversion to reduce SCM downtime.  This is of course less of an issue
if you could bring the conversion time down to a couple hours for even
the largest CVS repos.

2. Long-term continuous mirroring (backwards and forwards) between CVS
and another SCM, to allow people to use their preferred tool.  (I
actually think that this is a silly idea, but some people seem to like it.)

For both of these applications, incremental conversion would have to be
robust (for 1 it would at least have to give a clear indication of
unrecoverable errors).


Michael
