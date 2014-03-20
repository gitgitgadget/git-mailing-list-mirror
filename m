From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSOC 2014]idea:Git Configuration API Improvement
Date: Thu, 20 Mar 2014 09:47:53 +0100
Message-ID: <532AAB39.3010507@alum.mit.edu>
References: <1395300220-7540-1-git-send-email-zhaox383@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu.Moy@grenoble-inp.fr, peff@peff.net, git@vger.kernel.org
To: Yao Zhao <zhaox383@umn.edu>
X-From: git-owner@vger.kernel.org Thu Mar 20 09:56:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQYlc-0001N2-DE
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 09:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbaCTIzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 04:55:03 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58590 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743AbaCTIzA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 04:55:00 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Mar 2014 04:54:59 EDT
X-AuditID: 1207440c-f79656d000003eba-4a-532aab3d81af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 95.01.16058.D3BAA235; Thu, 20 Mar 2014 04:47:57 -0400 (EDT)
Received: from [192.168.69.148] (p5B15629D.dip0.t-ipconnect.de [91.21.98.157])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2K8lsgJ000629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Mar 2014 04:47:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395300220-7540-1-git-send-email-zhaox383@umn.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqGu7WivYYEqHkEXXlW4mi0uf17Na
	/GjpYbZ4NeEZmwOLx8Qvx1k9nvXuYfS4urCJ3ePzJrkAlihum6TEkrLgzPQ8fbsE7oyn23+w
	FDSwV/Rt28fSwHiatYuRk0NCwESit307E4QtJnHh3nq2LkYuDiGBy4wSm2a3M0E455gkXlxc
	wgZSxSugLfF4eR8jiM0ioCrxccY/ZhCbTUBXYlFPM9gkUYFgidWXH7BA1AtKnJz5BMwWEZCX
	uPv/NpjNLOAisejtLrCZwgJ2Eg0fesBmCgnYS+z41QZmcwo4SJz78hvI5gC6TlyipzEIolVH
	4l3fA2YIW15i+9s5zBMYBWch2TYLSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka
	6uVmluilppRuYoQEOs8Oxm/rZA4xCnAwKvHwrtijGSzEmlhWXJl7iFGSg0lJlPf9Sq1gIb6k
	/JTKjMTijPii0pzU4kOMEhzMSiK81u5AOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTU
	gtQimKwMB4eSBK/xKqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAExxcDYxgk
	xQO0Nwmknbe4IDEXKArReopRl2PDtjWNTEIsefl5qVLivB4ghwuAFGWU5sGtgKW1V4ziQB8L
	86aAjOIBpkS4Sa+AljABLeGfCrakJBEhJdXAKGi2R9rl95Oud1OyA6ctPdq9d2FZ5OTLMX+K
	4kRWf1NTl9kk9Ped+86keX1B3w8vWVRVuWbqg7JvgTs7pzc7a8zQsy5lUl1cOPFZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244525>

On 03/20/2014 08:23 AM, Yao Zhao wrote:
> Third one is about when to write back to file, I am really confused
> about it. I think one way could be when user leave git repository
> using "cd" to go back. But I am not sure if git could detect user
> calls "cd" to leave repository.

I don't understand.  The cache would be in memory, and would only live
as long as a single "git" process.  Within that process, if somebody
wants to change the config, they might (for example) call one function
to lock the config file, a second function to change the value(s) in
memory, and then a third function to flush the new config out to disk
and unlock the config file again.  The cache would usually only live for
milliseconds, not minutes/hours, so I don't think your question really
makes sense.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
