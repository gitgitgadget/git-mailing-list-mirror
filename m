From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] How to analyze future results of "Git User's Survey 2010" - correlations
Date: Mon, 11 Oct 2010 18:37:34 +0200
Message-ID: <201010111837.35124.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 18:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5LNm-0003gT-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab0JKQhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:37:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58102 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab0JKQho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:37:44 -0400
Received: by bwz15 with SMTP id 15so1807287bwz.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cxLbtTrlEmmPUtJXeNWfXvwJoyMY60tU8ClwmFh0pCw=;
        b=vkgo5Bq4lHku8omK5JOpttHT6lUd3vhzRECabVUJLc1LljG3mO60YZLpydw0n8BSpW
         52XDL0kdzkh/nmll9Ee2S2+5tspYwNkx5fXoM7Ac9igBgBDVqDNcJOSuTvO7yR8WVtjf
         irJgmVb3udwKMD8m1uVv8yyDtGown5sVWqnsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=FcITl/daaX5BO+Nikke8sueEhlKEmK7AXIJjpf6FZC9IQIn6S8bLf9lNS4ZsgAhYaF
         dv6f4LQjqeuyKxQDfS8FHORaScflya6Qc+IQJrSowHVJDO1XOzdKZPGknu5ow6q8pF62
         oz5gNmAW7cWrWoOXNrByY6uobpbeBwrOyKjdU=
Received: by 10.204.27.20 with SMTP id g20mr5292172bkc.114.1286815062078;
        Mon, 11 Oct 2010 09:37:42 -0700 (PDT)
Received: from [192.168.1.13] (abwu155.neoplus.adsl.tpnet.pl [83.8.244.155])
        by mx.google.com with ESMTPS id d27sm5686253bku.10.2010.10.11.09.37.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:37:41 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158780>

This email is intended to start discussion about how to analyze
results of "Git User's Survey 2010" when it finishes
  https://git.wiki.kernel.org/index.php/GitSurvey2010

Analyzing results of individual questions is fairly straighforward, so
let's talk mainly about more difficult issue: correlations between
answers.


Information about survey completion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0. Completion Rate Graph / Date of response
   
Unfortunately the last question "28. How did you hear about this Git
User's Survey?" doesn't provide a way to specify details about a way
one found about survey, i.e. what website, which IRC channel, address
of a mailing list or Google Group, name of Usenet newsgroup.

To find which announcements brought most responders, we can try to
correlate date of response with time of posting announcement (where it
is available).  Of course that would underplay the impact of later
announcements, because people who noticed it there might have noticed
it earlier somewhere else.

The export of survey data with individual responses include date and
time of response (in timezone of account; timezone is not specified in
data, unfortunately).  In addition to histogram with day-wide bins
(like the "Weekly" and "Monthly" plots in "Completion Rate Graph" on the
Analyze page for this survey: http://tinyurl.com/GitSurvey2010Analyze)
we can also display running "daily average" line plot, where value at
given point would be number of responses +/- 12 hours around given
time (24 hours i.e. a day centered around given time and date).

It is a pity that Survs.com doesn't provide (and probably also doesn't
gather) detailed account of views, and not only completed / finished
surveys (the "Viewed" number in "Survey Completion Statistics" box).


Another thing worth trying is to create a histogram of _time_ of
response, and perhaps try to correlate it with country of residence
(and range of timezones therein).


About you
^^^^^^^^^
1. What country do you live in (country of residence)?

If IP adresses (or at least parts of them) were available in export
data (they are in idividual responses tab, available on Analyze page
to members of 'git' account on Survs.com, with sufficient
permissions), then we could correlate country of residence with GeoIP
(country of ISP provider used to fill the survey).

We could try to use GeoTools (used by LogToMap) or StatPlanet Map
Maker, or a similar solution/tool, to generate map colored with number
of responders from given country.


2. How old are you (in years)?

Not much to correlate with, I think, though we can try to compare with
demographics from other surveys, or with world demographics (if we can
find such data).


Getting started with Git
^^^^^^^^^^^^^^^^^^^^^^^^
3. Have you found Git easy to learn?
4. Have you found Git easy to use?

Those two compared can show us whether Git is difficult, or just have
steep learning curve.

I also wonder how the correlation looks like and what the correlation
coefficient is for answers to those two questions.


5. Which Git version(s) are you using?

We can compare results against git versions distributed with major
distributions (perhaps limiting view to those responders that use
binary packages, or admin installs git),... though we have limited
resolution here.


6. Rate your own proficiency with Git (1-5):

Using this data we can check if novices and gurus use different tools,
use different features, want different features, etc.


How you use Git
^^^^^^^^^^^^^^^
7. I use Git for (check all that apply):

- work projects / unpaid projects
- proprietary projects / OSS development / private (unpublished)

We can try to use this data to check for example whether people use
different hosting services for OSS development (using public
repositories) and for proprietary development (private repositories on
hosting services or company internal).

- large (>1 MB) binary files
- often changing binary files

We can correlate this with people using git-bigfiles fork, and with
people wanting better support for large binary files in Git.


8. How do/did you obtain Git (install and/or upgrade)?
9. On which operating system(s) do you use Git?

We can correlate those two, and correlate them with git version used.


10. What Git interfaces, implementations and frontends do you use?
11. How often do you use following kinds of Git tools? 
12. What Git GUIs (graphical user interfaces) do you use?

Do answers to those questions depends on the level of proficiency with
Git?  Do people who use GUI find git hard to learn or hard to use
more (or do they find it less difficult)?

17. Which of the following features would you like to see
    implemented in git?
18. Describe what features would you like to have in Git, 
    if they are not present on the list above (in previous question)

We can check here if people who marked 'other, specify below' did
provide extended answer, or did they forget to fill it.


24. Have you tried to get help regarding Git from other people?
25. If yes, did you get these problems resolved quickly and to your 
liking?

Those two would be made into single question in next year, if there
will be Git User's Survey 2011.


26. What channel(s) did you use to request help?
27. Which communication channel(s) do you use?
    Do you read the mailing list, or watch IRC channel?

Those questions are about different things, but answers are probably
correlated to some extent.

-- 
Jakub Narebski
