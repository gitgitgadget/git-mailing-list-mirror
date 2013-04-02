From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] peel_onion(): teach $foo^{object} peeler
Date: Tue, 02 Apr 2013 18:32:58 +0200
Message-ID: <515B083A.5050808@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net> <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu> <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu> <7vboa1qtnb.fsf@alter.siamese.dyndns.org> <7vhajtpdtc.fsf@alter.siamese.dyndns.org> <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org> <515A94C7.3000406@alum.mit.edu> <7vfvz9gclo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:33:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN49L-0004D3-96
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761309Ab3DBQdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:33:01 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:48080 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758826Ab3DBQdA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 12:33:00 -0400
X-AuditID: 12074411-b7f286d0000008e8-8b-515b083b256b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E1.2E.02280.B380B515; Tue,  2 Apr 2013 12:33:00 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r32GWwhq021171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Apr 2013 12:32:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vfvz9gclo.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqGvDER1ocC/QoutKN5NFQ+8VZosf
	LT3MDswez3r3MHpcvKTs8XmTXABzFLdNUmJJWXBmep6+XQJ3xpSeSywFS7grVm9awtjA+I+j
	i5GDQ0LARGLhg7AuRk4gU0ziwr31bF2MXBxCApcZJR48PMcE4Rxjkpiy6RAjSBWvgLbE9/nz
	WEBsFgFViQcNe8DibAK6Eot6mplAbFGBMIm9F6axQdQLSpyc+QSsXkRATWJi2yEWkMXMAq4S
	n2ckgYSFBRwlXr/bD7VrLovEwoefwOZwCphJzPu9gxXEZhbQkXjX94AZwpaX2P52DvMERoFZ
	SFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghgSu4g3HG
	SblDjAIcjEo8vCe+RAUKsSaWFVfmHmKU5GBSEuVVYY4OFOJLyk+pzEgszogvKs1JLT7EKMHB
	rCTCG7cTqJw3JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCarwcEhsGbd6guMUix5
	+XmpShK87OxACwSLUtNTK9Iyc0oQSpk4OEEWcUmJFKfmpaQWJZaWZMSDIji+GBjDICkeoBs+
	sQG18xYXJOYCRSFaTzHqcnQt+vyKUQhsh5Q4rzjIDgGQoozSPLgVsPT1ilEc6Hth3i8go3iA
	qQ9u0iugJUxAS5bdCgdZUpKIkJJqYGw7si/qyYkpTwp3ONktvLul7opo/YFczk9lG4+59LJo
	7RRr7eoJs7hgc3p73FsxpvDwD0q+ZRGOXzJY3kz4Fr9k+4bLt06tmrfF9OO7Tx9f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219793>

On 04/02/2013 05:45 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Off topic: Your patch reminds me of something else that surprised me:
>> there is no "$userstring^{tag}".  I suppose it would be a bit ambiguous,
>> given that tags can point at tags, and it would also be less useful than
>> the other suffixes.  But its absence irked the completionist in me :-)
> 
> Yes, unfortunately, foo^{type} means "start from foo, and until what
> you are looking at it is of type, repeatedly peel to see if you can
> get to an object of that type, or stop and report an error".  If a
> tag A points at another tag B, which in turn points at an object C,
> you will never see B by applying usual peeling operator.
> 
> Also, v1.8.2^{tag} would be give the tag itself, while master^{tag}
> would not report the commit "master" but would error out, which
> would be useless.  You are better off doing `git cat-file -t foo`
> and seeing if it is a tag object at that point.

All correct, of course.  But the user would never use "master^{tag}"
unless he wants a tag and nothing else, so erroring out would be exactly
the thing he wants in that case.  This is no different than the
"^{commit}" part of "master^{tree}^{commit}", which correctly errors out
because a commit cannot be inferred from a tree.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
