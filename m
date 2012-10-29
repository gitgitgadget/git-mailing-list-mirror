From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Mon, 29 Oct 2012 06:10:04 +0100
Message-ID: <508E0FAC.5050600@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu> <7v7gqkgvxe.fsf@alter.siamese.dyndns.org> <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TShcN-0001ws-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab2J2FKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:10:15 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:48166 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab2J2FKN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 01:10:13 -0400
X-AuditID: 12074411-b7fa36d0000008cc-81-508e0fb47db5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 22.CD.02252.4BF0E805; Mon, 29 Oct 2012 01:10:12 -0400 (EDT)
Received: from [192.168.69.140] (p57A2593D.dip.t-dialin.net [87.162.89.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9T5A6iF001076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Oct 2012 01:10:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CAJDDKr4ki+NjSeuZpAU6bM=YAQ_3mdHCtawstdCqe9Ewvp=arQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsUixO6iqLuFvy/A4NxZXosNS9cwWxx584TZ
	outKN5NFQ+8VZosnc+8yWzybvJHd4ugpC4u2qVtYLH609DBbrH93ldmBy6O1v5vN4017L6PH
	zll32T0evupi93jWu4fR48L2k8weFy8pe3zeJBfAEcVtk5RYUhacmZ6nb5fAnbHq0TSWgkbp
	irNv0hoY/4l2MXJySAiYSFxZNYkNwhaTuHBvPZDNxSEkcJlRouHQU0YI5zSTxMFNS9lBqngF
	tCUurljADGKzCKhKdB38ANbNJqArsainmQnEFhUIk1i+czMTRL2gxMmZT1hAbBEBFYmdly+C
	bWAWuM4kcf7WbFaQhLCAr8TV4/OYILZtZpR41zgbbBunQKDEsoVLgDo4gDrUJdbPEwIJMwvI
	S2x/O4d5AqPALCQ7ZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK
	6SZGSMQI7mCccVLuEKMAB6MSD2/Tm94AIdbEsuLK3EOMkhxMSqK8eZx9AUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeJdyA5XzpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4
	lCR45/EBDRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHuXgbTz
	Fhck5gJFIVpPMepyfGyc95BRiCUvPy9VSpw3D6RIAKQoozQPbgUsPb5iFAf6WJi3G6SKB5ha
	4Sa9AlrCBLREhw/kueKSRISUVAPjjkx2nYin25b+cV8oVudykOl20rMzaqlciltk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208582>

On 10/29/2012 01:15 AM, David Aguilar wrote:
> On Sat, Oct 20, 2012 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> This patch series has the side effect that all of the directories
>>> listed in GIT_CEILING_DIRECTORIES are accessed *unconditionally* to
>>> resolve any symlinks that are present in their paths.  It is
>>> admittedly odd that a feature intended to avoid accessing expensive
>>> directories would now *intentionally* access directories near the
>>> expensive ones.  In the above scenario this shouldn't be a problem,
>>> because /home would be the directory listed in
>>> GIT_CEILING_DIRECTORIES, and accessing /home itself shouldn't be
>>> expensive.
>>
>> Interesting observation.  In the last sentence, "accessing /home"
>> does not exactly mean accessing /home, but accessing / to learn
>> about "home" in it, no?
>>
>>> But there might be other scenarios for which this patch
>>> series causes a performance regression.
>>
>> Yeah, after merging this to 'next', we should ask people who care
>> about CEILING to test it sufficiently.
>>
>> Thanks for rerolling.
> 
> GIT_CEILING_DIRECTORIES was always about trying to avoid
> hitting them at all; they can be (busy) NFS volumes there.
> 
> Here's the description from the 1.6.0 release notes:
> 
> * A new environment variable GIT_CEILING_DIRECTORIES can be used to stop
>   the discovery process of the toplevel of working tree; this may be useful
>   when you are working in a slow network disk and are outside any working tree,
>   as bash-completion and "git help" may still need to run in these places.
> 
> In 8030e44215fe8f34edd57d711a35f2f0f97a0423 Lars added
> GIT_ONE_FILESYSTEM to fix a related issue.
> Do you guys have GIT_CEILING_DIRECTORIES set too?
> 
> We use GIT_CEILING_DIRECTORIES and I'm pretty sure
> we don't want every git command hitting them, so this would
> be a regression when seen from the POV of our current usage
> of this variable, which would be a bummer.

I would certainly withdraw the patch series if it causes a performance hit.

The log message of the original commit (0454dd93bf) described the
following scenario: a /home partition under which user home directories
are automounted, and setting GIT_CEILING_DIRECTORIES=/home to avoid
hitting /home/.git, /home/.git/objects, and /home/objects (which would
attempt to automount those directories).  I believe that this scenario
would not be slowed down by my patches.

How do you use GIT_CEILING_DIRECTORIES that the proposed changes cause a
slowdown?

> Is there another way to accomplish this without the performance hit?
> Maybe something that can be solved with configuration?

Without doing the symlink expansion there is no way for git to detect
that GIT_CEILING_DIRECTORIES contains symlinks and is therefore
ineffective.  So the user has no warning about the misconfiguration
(except that git runs slowly).

On 10/29/2012 02:42 AM, Junio C Hamano wrote:
> Perhaps not canonicalize elements on the CEILING list ourselves? If
> we make it a user error to put symlinked alias in the variable, and
> document it clearly, wouldn't it suffice?

There may be no other choice.  (That, and fix the test suite in another
way to tolerate a $PWD that involves symlinks.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
