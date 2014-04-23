From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/6] test: add test_write_lines helper
Date: Wed, 23 Apr 2014 20:58:34 +0300
Message-ID: <20140423175834.GC28308@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
 <1398255277-26303-2-git-send-email-mst@redhat.com>
 <xmqqd2g80x21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:57:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1Qj-0008E0-A5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbaDWR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbaDWR5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:57:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NHvonJ004250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2014 13:57:50 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NHvnh8028330;
	Wed, 23 Apr 2014 13:57:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2g80x21.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246859>

On Wed, Apr 23, 2014 at 10:34:30AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > As suggested by Junio.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Ehh, I would probably not suggest such an implementation though.
> 
> 	test_write_lines () {
> 		printf "%s\n" "$@"
> 	}
> 
> might be, but not with "echo" and semicolon on the same line as
> "for" ;-).

Okay I didn't know printf reuses format in bash, cute trick.

Do you want to rewrite it yourself or want me to post a
new version?


> >  t/test-lib-functions.sh | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index aeae3ca..2fa6453 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -712,6 +712,13 @@ test_ln_s_add () {
> >  	fi
> >  }
> >  
> > +# This function writes out its parameters, one per line
> > +test_write_lines () {
> > +	for line in "$@"; do
> > +		echo "$line"
> > +	done
> > +}
> > +
> >  perl () {
> >  	command "$PERL_PATH" "$@"
> >  }
