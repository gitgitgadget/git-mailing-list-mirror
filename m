From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSOC Proposal.
Date: Tue, 27 Mar 2012 13:47:55 +0100
Message-ID: <201203271447.58519.jnareb@gmail.com>
References: <CAH-tXsAY0GErMAwi_TMaq0S4GuGx-OcPtEkJnXNqfGEyQq44_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 14:48:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCVot-0002eG-TK
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 14:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab2C0MsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 08:48:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48789 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2C0MsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 08:48:04 -0400
Received: by wejx9 with SMTP id x9so4887191wej.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+rYL9vi8k3Bf9i3f/fvEkXmz5fVWOfiO9CbX9ovdWAo=;
        b=xGbG1g3IhEtbtYHTRR1PSGiuKVx9iTYXlCNivGdIbE6SrQ5UoKYU/RMk62IHyuF6xk
         RKmBG3M/L0AxpZp8ngF2IosKnfyjhYn9NCS9S8LTFmhPxnCE7r+GhfO26c/olwuZNgA8
         lUeYQl2LPVyo2uYz42fb6qhfHZsP3SOLsDbe2V0sxb9z3m3bK0e08Kv5dTyZ9/YNrq+r
         PYsrjwHkaggu+EMA2fwuC6AJPxzpctKsOyK0b7QFz2cpS1n+ZdDfJbsu880LeqMNXsNV
         522UGyl7eDQcW3NfL8hXYUCRnnqIuKZcxLpX3lRlmgO1ksJJz0ExyyT96LNkCIEoRBVb
         EFGQ==
Received: by 10.216.139.140 with SMTP id c12mr13460598wej.43.1332852482861;
        Tue, 27 Mar 2012 05:48:02 -0700 (PDT)
Received: from [192.168.1.13] (acxa35.neoplus.adsl.tpnet.pl. [83.11.158.35])
        by mx.google.com with ESMTPS id fl2sm80886548wib.4.2012.03.27.05.48.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 05:48:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAH-tXsAY0GErMAwi_TMaq0S4GuGx-OcPtEkJnXNqfGEyQq44_A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194042>

On Tue, 27 Mar 2012, jaseem abid wrote:

> Hello everyone,
> 
> I am interested in participating in GSoC 2012. I have gone through the
> ideas page and  mailing list archives by now.  I would like to suggest a
> new approach for the git instaweb rather than just JavaScript rewrite,
> which i believe can improve the overall quality of the software.

First of all, it is _gitweb_ that is git web interface subsystem.
git-instaweb is the name of script that runs gitweb (using available
web server, including apache, lighttpd, webrick and plackup) and by
default also start web browser opening gitweb, for a repository you
are in.  This is important difference.
 
For the rest I'll assume s/instaweb/gitweb/.

Second, the proposed "Use JavaScript library / framework in gitweb"
project has the advantage of being possible to be done in incremental
improvements (even without expanding client-side scripting in gitweb,
i.e. adding new features possible with using JavaScript library),
rather than all-or-nothing complete rewrite.  The potential for failure
is much higher in "rewrite" project.


It is nice that there is a would-be prospective student that proposes
his own blue-sky idea of a project.  The projects listed on

  https://github.com/peff/git/wiki/SoC-2012-Ideas

were meant to be only _example_ ideas.


> Data and presentation are too tightly bound in the current code base of
> gitweb. CSS classes are hard coded in the Perl script and it makes
> further development difficult and is considered to be a bad practice
> generally.

Separation of content and presentation is considered a good practice,
but it would require in my opinion heavy rewrite to use one of existing
Perl web (micro)frameworks[1] rather than pure old CGI.pm and hand-crafted
code plus some templating engine[2].  This is IMVHO too much work to do
in a single Google Summer of Code.

Though rewriting gitweb using Perl web framework / creating new web
interface based on gitweb could be a good GSoC project.  The problem
might be with selecting self contained set of work that can be done
in time available for GSoC.

Also there is advantage in gitweb using only minimal number of non-core
required Perl modules.  There is always Gitalist, a git web interface
written using Catalyst MVC framework (based originally on some old gitweb
code, much extended since).

[1] For example one of modern PSGI-based microframeworks like Dancer
    or Mojolicious.
[2] For example Template::Toolkit, or HTML::Zoom, or Template::Declare.

> Presentable HTML is the only output from gitweb as of now that 
> can't be used by anything other than a browser.

It doesn't make much sense to use in something other than a browser.
_What_ other use do you think about?

YAGNI, and don't overengineer.

> Using Perl to generate raw 
> data in JSON format (XML will also do, but not preferred) and using
> JavaScript to render it in the browser will lead to the separation of the
> application into multiple modules.

NO.  Requiring JavaScript to be able to render gitweb output is totally
out of question.  Especially for intended audience, which is composed
heavily of programmers and hackers, both of which are prone to using text
web browsers and running NoScript-equivalents or just with JavaScript
turned off.

Note also that splitting gitweb into smaller modules would be not easy,
as it will require reworking current "longjump"-based (non-local goto
outside subroutine) error handling into e.g. exception-based one
(e.g. Try::Tiny + HTTP::Exception)... or porting gitweb to web framework
which does that for us.

Anyway using JSON for output and _client side_ JavaScript for generating
(X)HTML and CSS looks like monumentally stupid idea.

> A Perl hacker can improve JSON 
> generating modules someday without bothering what is being done to the data
> after it is generated.

If / when gitweb is properly split into separate modules, this can be
done by generating Perl data structures (OOP or not), rather than going
microkernel-like design of bogging down performance with marshalling
and unmarshalling to and from JSON.

Proper separation of responsibilities and proper API design and improving
contents side can be done independently on presentation side.

> A JavaScript programmer can use this data to do any 
> of the tasks listed efficiently without bothering how it is being
> generated. This potentially opens the project to a wide developer audience
> and most probably much more efficient code. Generating UI in Perl for non
> JavaScript browsers can be implemented as a 3rd module. The languages fit
> in the context very well.

<irony>
Yep, and adding new view, or new feature in an existing view will require
both knowledge of Perl (to get data) and JavaScript + JS library (to show
data).  Wonderfull way of enlarging pool of possible gitweb developers.
</irony>

> I have submitted a detailed proposal on the melange website. Mentors please
> be kind to go through the same.
> 
> http://www.google-melange.com/gsoc/proposal/review/google/gsoc2012/jaseemabid/1

-- 
Jakub Narebski
Poland
