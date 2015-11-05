From: David Turner <dturner@twopensource.com>
Subject: Re: File owner/group and git
Date: Thu, 05 Nov 2015 12:57:00 -0500
Organization: Twitter
Message-ID: <1446746220.4131.57.camel@twopensource.com>
References: <1446689037.4131.47.camel@twopensource.com>
	 <xmqqoaf9891r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 18:57:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuOmd-0003UE-9s
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162124AbbKER5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 12:57:06 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35158 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162092AbbKER5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 12:57:04 -0500
Received: by qgec40 with SMTP id c40so12014089qge.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=WxsgWWlHVosC3CxcZLCDe8JQJ7TUPb8d0HxcVK7WOcg=;
        b=nt7BOYSiMhGdnAZZBov7mUpTgOJIbKe1Xu8bmNMfbajGeZAjWgkgrxGXDi0XrbLHO2
         ycJwiROWM9BATa5oQLsKIhh+v3zSCkrprwirVSPZ8Q/BJypHO0s6v7vJZwInEgj155us
         HXRoTLp0lxMrHAfukxX5QrhNQWw3ZJnrW0BWxzo9FAWzh1jLXydXfajY3PJBoCGl5tJ2
         JkH4F0gRKgaILr7A5TdBQWWR6vBR3i9+XmcGGHqaYAbHYR7HlGDVwQ/NzFjQQgN5V38d
         0K3Q2Io3Gd6tKJeilcWbGJEPHm6xPWcEOY8cSLYXKQChsFKhyx7yczCGcOsoBY8a/IeE
         y1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=WxsgWWlHVosC3CxcZLCDe8JQJ7TUPb8d0HxcVK7WOcg=;
        b=gvt3Ka19tYW24Pd+wxUBFGQ6WqCeAz/IFwLzS3hbRpOpeOd5GmyhLi7bOx5M3tpgpN
         XDz9BZX/mgvtti4AiaYSjXuiNXw8U9Gh/xlOcOndTo3J8gzWi93nYCZIuLcvZvZfmAOZ
         eZD7SFxvnNsuo3uUfXGA6Bz3kzl7NwyEqrS6UkpBuIUFD+Fm51rVk49XFhRtvuw3fMzz
         c62sVFhUaF/QAS9Bjnk4WMGzKlyM4IGN1bDhbzT/c8dM8OhzZlLni3YrMoqacLPPflBS
         aQuFnadoCxSCg+oo8KzNQe8NujQrEsgzt88eSemB/H8j5OMFuF/0IbTGi91Wz3jSYEsH
         Ybtg==
X-Gm-Message-State: ALoCoQnxNSvsJRuOMjZxaENkQrV9cJPkUbHEnSMsp0V6VhzwPv7mOvghePsoacL62fUBENWJkQEs
X-Received: by 10.140.34.204 with SMTP id l70mr8823037qgl.24.1446746222506;
        Thu, 05 Nov 2015 09:57:02 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id e80sm1904486qka.38.2015.11.05.09.57.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 09:57:01 -0800 (PST)
In-Reply-To: <xmqqoaf9891r.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280927>

On Wed, 2015-11-04 at 18:38 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > In unpack-trees.c, in verify_uptodate_1, we check ie_match_stat.  This
> > returns OWNER_CHANGED if a file has changed ownership since the index
> > was updated.  Do we actually care about that particular case?  Or really
> > anything other than DATA_CHANGED?
> 
> That's a 10-year old code and there aren't that many people left
> who can answer the original rationale, I am afraid ;-)
> 
> In general, "Do we actually care?" is not the question we ask in
> this area of the code.  "Does it help us to catch real changes, or
> does it change spuriously to make it too unreliable a signal to be
> useful?" is the question that drives the design of this part of the
> system.
> 
> DATA_CHANGED is "we know the contents are different without even
> looking at the data".  If the size is different from the last time
> we hashed the data, the contents must have changed.  The inverse is
> not true (and that is half of the "racy git" issue).
> 
> Other *_CHANGED are finely classified only because originally we
> didn't really know which are useful to treat as notable change
> event, and "changed" variable had sufficient number of bits to hold
> different classification, so that we could pick and choose which
> ones we truly care.  We knew MTIME was useful in the sense that even
> if the size is the same, updated mtime is good enough indication
> that the stuff has changed, even to "make" utility.
> 
> INODE and CTIME are not so stable on some filesystems (e.g. inum may
> not be stable on a network share across remount) and in some
> environments (e.g. some virus scanners touch ctime to mark scanned
> files, cf. 1ce4790b), and would trigger false positives too often to
> be useful.  We always paid attention to them initially, but there
> are configurations to tell Git not raise them these days.
> 
> OWNER probably falls into a category that is stable enough to be
> useful, as the most likely way for it to change is not by running
> "chown" on the file in-place (which does not change the contents),
> but by running "mv" to drop another file owned by somebody else to
> the original location (which likely does change the contents).  At
> the same time, "mv" a different file into the path would likely
> trigger changes to INODE and MTIME as well, so it cannot be more
> than belt-and-suspenders measure to catch modification.  In that
> sense ignoring OWNER would not hurt too much.
> 
> If it changes spuriously to make it too unreliable a signal to be
> useful, it certainly is OK to introduce a knob to ignore it.  It
> might even make sense to ignore it unconditionally if the false hit
> happens too frequently, but offhand my gut reaction is that there
> may be something wrong in the environment (i.e. system outside Git
> in which Git runs) if owner/group changes spuriously to cause
> issues.

Thanks.

The only case where we saw it was with our watchman code, which lies
about ownership (to save space/time).  We're going to try ignoring
OWNER_CHANGED in our watchman branch, and if that fixes the issue for
our users, we'll stop worrying about it on the theory that Duy's
watchman stuff is the long-term path forward, and it doesn't have this
issue.
