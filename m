From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 06 May 2013 12:28:03 +0200
Message-ID: <518785B3.3050606@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 12:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZIeb-0007kO-S7
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 12:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab3EFK2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 06:28:13 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:64808 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753920Ab3EFK2J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 06:28:09 -0400
X-AuditID: 12074414-b7fb86d000000905-7e-518785b84e0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B8.76.02309.8B587815; Mon,  6 May 2013 06:28:08 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r46AS4mr001333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 06:28:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqLujtT3Q4Ox8MYtfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfG9gX7mQve8VUcefGNqYHxL3cXIyeHhICJxPrDTUwQtpjEhXvr2boYuTiEBC4z
	SrxuusMC4RxjkjjYcIYZpIpXQFvi/YU3jCA2i4CqxLTpK8DibAK6Eot6msEmiQqESaxavwyq
	XlDi5MwnLCC2iIChxN72qWBDmQXOM0oc/PCEHSQhLGAvsevLdFaIbR8ZJbYeOQJUxcHBKRAo
	MXlpBIjJLKAusX6eEEg5s4C8xPa3c5gnMArMQrJiFkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm
	6xYnJ+blpRbpWujlZpbopaaUbmKEBLrIDsYjJ+UOMQpwMCrx8BY8aQsUYk0sK67MPcQoycGk
	JMrr1dIeKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE12cvUDlvSmJlVWpRPkxKmoNFSZz322J1
	PyGB9MSS1OzU1ILUIpisDAeHkgTvVJChgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ
	8aBIjS8GxipIigdobzNIO29xQWIuUBSi9RSjLsfKK09eMwqx5OXnpUqJ864DKRIAKcoozYNb
	AUtrrxjFgT4W5l0PUsUDTIlwk14BLWECWpLAB7akJBEhJdXA6B39VieqRcbwi1mi3RTPK0af
	Uv8c5fJt4pbIS12jvYivMaF0VjyXT5adXM8eTe/fQUmLDu82tu4QWediVf9gXtOr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223438>

On 05/03/2013 08:23 PM, Felipe Contreras wrote:
> On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> How do we know that this doesn't break any users of fast-import?  Your
>> comment isn't very reassuring:
>>
>>> the vast majority of them will never be used again
>>
>> So what's with the minority?
> 
> Actually I don't think there's any minority. If the client program
> doesn't store blobs, the blob marks are not used anyway. So there's no
> change.

I haven't been following this conversation in detail, but your proposed
change sounds like something that would break cvs2git [1].  Let me
explain what cvs2git does and why:

CVS stores all of the revisions of a single file in a single filename,v
file in rcsfile(5) format.  The revisions are stored as deltas ordered
so that a single revision can be reconstructed from a single serial read
of the file.

cvs2git reads each of these files once, reconstructing *all* of the
revisions for a file in a single go.  It then pours them into a
git-fast-import stream as blobs and sets a mark on each blob.

Only much later in the conversion does it have enough information to
reconstruct tree-wide commits.  At that time it outputs git-fast-import
data (to a second file) defining the git commits and their ancestry.
The contents are defined by referring to the marks of blobs from the
first git-fast-import stream file.

This strategy speeds up the conversion *enormously*.

So if I understand correctly that you are proposing to stop allowing
marks on blob objects to be set and/or referred to later, then I object
vociferously.

If I've misunderstood then I'll go back into my hole :-)

Michael

[1] http://cvs2svn.tigris.org/cvs2git.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
